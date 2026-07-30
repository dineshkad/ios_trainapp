// RailRadar/Features/MyTrains/MyTrainsView.swift

import SwiftUI

struct MyTrainsView: View {
    @StateObject private var viewModel: MyTrainsViewModel
    private let trainRepository: TrainRepositoryProtocol
    private let onboardService: OnboardTrackingServiceProtocol

    init(
        trainRepository: TrainRepositoryProtocol,
        onboardService: OnboardTrackingServiceProtocol
    ) {
        self.trainRepository = trainRepository
        self.onboardService = onboardService
        _viewModel = StateObject(wrappedValue: MyTrainsViewModel(trainRepository: trainRepository))
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle("My Trains")
                .task {
                    await viewModel.loadJourneys()
                }
                .refreshable {
                    await viewModel.loadJourneys()
                }
        }
    }

    private var content: some View {
        Group {
            // ... same loading/error/empty states as before ...

            List {
                ForEach(MyTrainsViewModel.Section.allCases) { section in
                    if let journeys = viewModel.sections[section], !journeys.isEmpty {
                        Section(header: Text(section.rawValue)) {
                            ForEach(journeys) { journey in
                                NavigationLink(
                                    destination: TrainDetailView(
                                        journey: journey,
                                        trainRepository: trainRepository,
                                        onboardService: onboardService
                                    )
                                ) {
                                    JourneyRowView(journey: journey)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }

    // allJourneysEmpty etc. remain the same
}
