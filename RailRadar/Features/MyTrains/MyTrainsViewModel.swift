//
//  MyTrainsViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/MyTrains/MyTrainsViewModel.swift

import Foundation
import Combine

final class MyTrainsViewModel: ObservableObject {
    enum Section: String, CaseIterable, Identifiable {
        case today = "Today"
        case upcoming = "Upcoming"
        case past = "Past"

        var id: String { rawValue }
    }

    @Published private(set) var sections: [Section: [Journey]] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let trainRepository: TrainRepositoryProtocol

    init(trainRepository: TrainRepositoryProtocol) {
        self.trainRepository = trainRepository
    }

    @MainActor
    func loadJourneys() async {
        isLoading = true
        errorMessage = nil

        do {
            let journeys = try trainRepository.fetchJourneys()
            sections = Self.group(journeys: journeys)
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }

    private static func group(journeys: [Journey]) -> [Section: [Journey]] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        var result: [Section: [Journey]] = [
            .today: [],
            .upcoming: [],
            .past: []
        ]

        for journey in journeys {
            let journeyDay = calendar.startOfDay(for: journey.journeyDate)

            if calendar.isDate(journeyDay, inSameDayAs: today) {
                result[.today, default: []].append(journey)
            } else if journeyDay > today {
                result[.upcoming, default: []].append(journey)
            } else {
                result[.past, default: []].append(journey)
            }
        }

        // Sort each section by date
        for (section, list) in result {
            result[section] = list.sorted { $0.journeyDate < $1.journeyDate }
        }

        return result
    }
}
