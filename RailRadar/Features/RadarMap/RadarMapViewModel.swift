//
//  RadarMapViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/RadarMap/RadarMapViewModel.swift

import Foundation
import MapKit
import Combine

struct TrainAnnotation: Identifiable {
    let id = UUID()
    let trainNumber: String
    let trainName: String
    let coordinate: CLLocationCoordinate2D
    let category: String? // e.g., Rajdhani, Superfast
}

final class RadarMapViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var annotations: [TrainAnnotation] = []
    @Published var errorMessage: String?

    private let trainRepository: TrainRepositoryProtocol
    private let tierManager: TierManager

    init(trainRepository: TrainRepositoryProtocol, tierManager: TierManager = .shared) {
        self.trainRepository = trainRepository
        self.tierManager = tierManager

        // Center roughly on India
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 22.9734, longitude: 78.6569),
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        )
    }

    var canUseRadarMap: Bool {
        tierManager.canUseRadarMap
    }

    @MainActor
    func loadAnnotations() async {
        guard canUseRadarMap else {
            errorMessage = "RadarMap is a Pro feature."
            annotations = []
            return
        }

        errorMessage = nil

        do {
            let journeys = try trainRepository.fetchJourneys()

            // For Phase 3, we don't have real coordinates per journey.
            // We'll stub coordinates around a few major cities.
            let baseCoordinates: [CLLocationCoordinate2D] = [
                CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), // New Delhi
                CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777), // Mumbai
                CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707), // Chennai
                CLLocationCoordinate2D(latitude: 22.5726, longitude: 88.3639)  // Kolkata
            ]

            var result: [TrainAnnotation] = []
            for (index, journey) in journeys.enumerated() {
                let coord = baseCoordinates[index % baseCoordinates.count]
                let annotation = TrainAnnotation(
                    trainNumber: journey.trainNumber,
                    trainName: journey.trainName,
                    coordinate: coord,
                    category: nil
                )
                result.append(annotation)
            }

            annotations = result
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
