//
//  PassportViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/Passport/PassportViewModel.swift

import Foundation
import Combine

struct PassportStats {
    let totalJourneys: Int
    let totalDistance: Int      // km
    let totalDuration: TimeInterval // seconds
}

final class PassportViewModel: ObservableObject {
    @Published private(set) var stats: PassportStats = PassportStats(
        totalJourneys: 0,
        totalDistance: 0,
        totalDuration: 0
    )
    @Published var errorMessage: String?

    private let trainRepository: TrainRepositoryProtocol
    private let tierManager: TierManager

    init(trainRepository: TrainRepositoryProtocol, tierManager: TierManager = .shared) {
        self.trainRepository = trainRepository
        self.tierManager = tierManager
    }

    var isPro: Bool {
        tierManager.canUseRadarMap // using canUseRadarMap as a proxy for Pro for now
    }

    @MainActor
    func loadStats() async {
        do {
            let journeys = try trainRepository.fetchJourneys()

            let totalJourneys = journeys.count
            let totalDistance = journeys.reduce(0) { $0 + $1.distance }
            let totalDuration = journeys.reduce(0) { $0 + $1.duration }

            stats = PassportStats(
                totalJourneys: totalJourneys,
                totalDistance: totalDistance,
                totalDuration: totalDuration
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
