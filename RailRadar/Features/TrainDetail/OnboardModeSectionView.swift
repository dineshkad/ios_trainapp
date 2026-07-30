//
//  OnboardModeSectionView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/TrainDetail/OnboardModeSectionView.swift

import SwiftUI

struct OnboardModeSectionView: View {
    @ObservedObject var viewModel: TrainDetailViewModel
    @State private var isOnboard: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Toggle(isOn: $isOnboard) {
                Text("I’m on this train")
                    .font(.headline)
            }
            .onChange(of: isOnboard) { newValue in
                viewModel.toggleOnboardMode(isOn: newValue)
            }

            switch viewModel.onboardStatus.state {
            case .notOnboard:
                Text("Onboard tracking is off.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            case .betweenStations:
                Text("Between stations. GPS-based tracking will be enabled soon.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            case .atStation(let code):
                Text("At station: \(code)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            case .arrivingSoon(let code):
                Text("Arriving soon at: \(code)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
