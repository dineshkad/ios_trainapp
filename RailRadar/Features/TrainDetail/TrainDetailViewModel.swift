//
//  TrainDetailViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//


// RailRadar/Features/TrainDetail/TrainDetailViewModel.swift

import Foundation
import Combine

final class TrainDetailViewModel: ObservableObject {
    enum LoadingState {
        case idle
        case loading
        case loaded
        case failed(String)
    }

    @Published var journey: Journey
    @Published var train: Train?
    @Published var liveStatus: LiveStatusSnapshot?
    @Published var loadingState: LoadingState = .idle


    @Published var onboardStatus: OnboardStatus = OnboardStatus(
        state: .notOnboard,
        distanceRemaining: nil,
        etaToNextStation: nil,
        etaToDestination: nil
    )

    private let trainRepository: TrainRepositoryProtocol
    private let onboardService: OnboardTrackingServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(
        journey: Journey,
        trainRepository: TrainRepositoryProtocol,
        onboardService: OnboardTrackingServiceProtocol
    ) {
        self.journey = journey
        self.trainRepository = trainRepository
        self.onboardService = onboardService

        onboardService.statusPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                self?.onboardStatus = status
            }
            .store(in: &cancellables)
    }


    @MainActor
    func load() async {
        loadingState = .loading

        do {
            let train = try await trainRepository.getSchedule(for: journey.trainNumber)
            self.train = train

            let snapshot = try await trainRepository.getLiveStatus(for: journey.trainNumber, journeyDate: journey.journeyDate)
            self.liveStatus = snapshot

            loadingState = .loaded
        } catch {
            loadingState = .failed(error.localizedDescription)
        }
    }

    func toggleOnboardMode(isOn: Bool) {
        if isOn {
            onboardService.startTracking(journey: journey)
        } else {
            onboardService.stopTracking()
        }
    }
}
