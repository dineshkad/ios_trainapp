//
//  JourneyRowView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/MyTrains/JourneyRowView.swift

import SwiftUI

struct JourneyRowView: View {
    let journey: Journey

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(journey.trainNumber)
                    .font(.headline)
                Text("•")
                Text(journey.trainName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            HStack {
                Text(journey.journeyDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Live status coming soon")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
