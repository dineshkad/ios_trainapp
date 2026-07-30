//
//  SubscriptionSectionView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Settings/SubscriptionSectionView.swift

import SwiftUI

struct SubscriptionSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("RailRadar Pro")
                    .font(.headline)
                Spacer()
                Text("PRO")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.purple.opacity(0.2))
                    .foregroundColor(.purple)
                    .cornerRadius(6)
            }

            Text("Unlock RadarMap, advanced stats, Live Activities, and more.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button {
                // Placeholder for StoreKit purchase flow
            } label: {
                Text("Get Pro")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
