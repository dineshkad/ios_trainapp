//
//  PassportView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Passport/PassportView.swift

import SwiftUI

struct PassportView: View {
    @StateObject private var viewModel: PassportViewModel

    init(trainRepository: TrainRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: PassportViewModel(trainRepository: trainRepository))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Placeholder background (later: real MapKit map)
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                PassportStatsCard(
                    stats: viewModel.stats,
                    isPro: viewModel.isPro
                )
                .padding()
            }
        }
        .navigationTitle("Passport")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadStats()
        }
        .overlay(
            Group {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .padding()
                }
            },
            alignment: .top
        )
    }
}
