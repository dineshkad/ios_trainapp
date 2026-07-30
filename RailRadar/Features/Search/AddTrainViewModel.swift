<<<<<<< HEAD
//
//  AddTrainViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
=======
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
// RailRadar/Features/Search/AddTrainViewModel.swift

import Foundation
import Combine

final class AddTrainViewModel: ObservableObject {
    struct SearchResult: Identifiable, Hashable {
        let id = UUID()
        let trainNumber: String
        let trainName: String
        let suggestedDate: Date
    }

    @Published var query: String = ""
    @Published var results: [SearchResult] = []
    @Published var selectedResult: SearchResult?
    @Published var journeyDate: Date = Date()
    @Published var isSaving: Bool = false
    @Published var saveErrorMessage: String?

    private let trainRepository: TrainRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(trainRepository: TrainRepositoryProtocol) {
        self.trainRepository = trainRepository

        $query
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
<<<<<<< HEAD
                self?.performSearch(text)
=======
                Task {
                    await self?.performSearch(text)
                }
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
            }
            .store(in: &cancellables)
    }

<<<<<<< HEAD
    private func performSearch(_ text: String) {
=======
    @MainActor
    private func performSearch(_ text: String) async {
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
        guard !text.isEmpty else {
            results = []
            return
        }

<<<<<<< HEAD
        // Phase 3: simple stubbed search.
        // Later: integrate real lookup + API.
        let lowercased = text.lowercased()

        let stub = [
            SearchResult(trainNumber: "17210", trainName: "Seshadri Express", suggestedDate: Date()),
            SearchResult(trainNumber: "17211", trainName: "Kondaveedu Express", suggestedDate: Date())
        ]

        results = stub.filter {
            $0.trainNumber.contains(text) ||
            $0.trainName.lowercased().contains(lowercased)
=======
        do {
            let trains = try await trainRepository.searchTrains(by: text)
            results = trains.map {
                SearchResult(
                    trainNumber: $0.number,
                    trainName: $0.name,
                    suggestedDate: Date()
                )
            }
        } catch {
            print("Search error: \(error.localizedDescription)")
            results = []
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
        }
    }

    func selectResult(_ result: SearchResult) {
        selectedResult = result
        journeyDate = result.suggestedDate
    }

    @MainActor
    func saveJourney() async {
        guard let selected = selectedResult else { return }
        isSaving = true
        saveErrorMessage = nil

<<<<<<< HEAD
        // For Phase 3, we don't know distance/duration yet; use placeholders.
=======
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
        let journey = Journey(
            trainNumber: selected.trainNumber,
            trainName: selected.trainName,
            journeyDate: journeyDate,
            boardingStationCode: nil,
            alightingStationCode: nil,
            distance: 0,
            duration: 0,
<<<<<<< HEAD
            tierSource: .free // TierManager could refine this later
=======
            tierSource: .free
>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
        )

        do {
            try trainRepository.saveJourney(journey)
            isSaving = false
        } catch {
            isSaving = false
            saveErrorMessage = error.localizedDescription
        }
    }
}
