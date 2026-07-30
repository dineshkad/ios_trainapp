//
//  TrainDetailView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/TrainDetail/TrainDetailView.swift

import SwiftUI

struct TrainDetailView: View {
    @StateObject private var viewModel: TrainDetailViewModel

    init(
        journey: Journey,
        trainRepository: TrainRepositoryProtocol,
        onboardService: OnboardTrackingServiceProtocol
    ) {
        _viewModel = StateObject(
            wrappedValue: TrainDetailViewModel(
                journey: journey,
                trainRepository: trainRepository,
                onboardService: onboardService
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header

                OnboardModeSectionView(viewModel: viewModel)

<<<<<<< HEAD
                if let train = viewModel.train {
                    TimelineView(train: train, journeyDate: viewModel.journey.journeyDate)
                        .padding(.top, 8)
                } else {
                    Text("Loading schedule…")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                // Placeholder for map integration later
=======
                switch viewModel.loadingState {
                case .idle, .loading:
                    Text("Loading schedule…")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                case .failed(let message):
                    Text("Failed to load schedule: \(message)")
                        .font(.subheadline)
                        .foregroundColor(.red)
                case .loaded:
                    if let train = viewModel.train {
                        TimelineView(train: train, journeyDate: viewModel.journey.journeyDate)
                            .padding(.top, 8)
                    }
                }

>>>>>>> 6303420 (Phase 4: wire RailRadar API into search and train detail)
                Text("Map view will show route and live position here.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle("\(viewModel.journey.trainNumber) • \(viewModel.journey.trainName)")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.journey.trainNumber) • \(viewModel.journey.trainName)")
                .font(.title2)
                .bold()

            HStack {
                Text("Journey Date:")
                Text(viewModel.journey.journeyDate, style: .date)
                    .bold()
            }
            .font(.subheadline)

            if let boarding = viewModel.journey.boardingStationCode,
               let alighting = viewModel.journey.alightingStationCode {
                Text("\(boarding) → \(alighting)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("Full route")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
