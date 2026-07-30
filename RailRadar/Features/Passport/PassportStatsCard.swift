//
//  PassportStatsCard.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/Passport/PassportStatsCard.swift

import SwiftUI

struct PassportStatsCard: View {
    let stats: PassportStats
    let isPro: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ALL-TIME RAILRADAR PASSPORT")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Trains")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(stats.totalJourneys)")
                        .font(.title2)
                        .bold()
                }

                VStack(alignment: .leading) {
                    Text("Distance")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(stats.totalDistance) km")
                        .font(.title2)
                        .bold()
                }

                VStack(alignment: .leading) {
                    Text("Time")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(Self.format(duration: stats.totalDuration))
                        .font(.title2)
                        .bold()
                }
            }

            if !isPro {
                Text("Upgrade to RailRadar Pro for detailed stats and history.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }

    private static func format(duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return "\(hours)h \(minutes)m"
    }
}
