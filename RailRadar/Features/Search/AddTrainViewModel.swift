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
                Task {
                    await self?.performSearch(text)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func performSearch(_ text: String) async {
        guard !text.isEmpty else {
            results = []
            return
        }

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

        let journey = Journey(
            trainNumber: selected.trainNumber,
            trainName: selected.trainName,
            journeyDate: journeyDate,
            boardingStationCode: nil,
            alightingStationCode: nil,
            distance: 0,
            duration: 0,
            tierSource: .free
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
