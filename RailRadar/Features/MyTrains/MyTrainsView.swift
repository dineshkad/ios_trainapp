//
//  MyTrainsView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/MyTrains/MyTrainsView.swift

import SwiftUI

struct MyTrainsView: View {
    @StateObject private var viewModel: MyTrainsViewModel

    init(trainRepository: TrainRepositoryProtocol) {
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
            if viewModel.isLoading {
                ProgressView("Loading journeys…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                VStack(spacing: 8) {
                    Text("Failed to load journeys")
                        .font(.headline)
                    Text(error)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if allJourneysEmpty {
                VStack(spacing: 8) {
                    Text("No journeys yet")
                        .font(.headline)
                    Text("Use the Search tab to add your first train journey.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(MyTrainsViewModel.Section.allCases) { section in
                        if let journeys = viewModel.sections[section], !journeys.isEmpty {
                            Section(header: Text(section.rawValue)) {
                                ForEach(journeys) { journey in
                                    JourneyRowView(journey: journey)
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
    }

    private var allJourneysEmpty: Bool {
        MyTrainsViewModel.Section.allCases.allSatisfy { section in
            (viewModel.sections[section] ?? []).isEmpty
        }
    }
}
