//
//  SearchResultRow.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Search/SearchResultRow.swift

import SwiftUI

struct SearchResultRow: View {
    let result: AddTrainViewModel.SearchResult

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(result.trainNumber)
                    .font(.headline)
                Text(result.trainName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(result.suggestedDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
