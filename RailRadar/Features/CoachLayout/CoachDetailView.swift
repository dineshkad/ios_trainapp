//
//  CoachDetailView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/CoachLayout/CoachDetailView.swift

import SwiftUI

struct CoachDetailView: View {
    let layout: CoachLayout
    let userBerthNumber: Int?

    private let columns = [
        GridItem(.adaptive(minimum: 60), spacing: 8)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Coach \(layout.code)")
                .font(.headline)

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(layout.berths, id: \.number) { berth in
                    let isUser = berth.number == userBerthNumber
                    Text("\(berth.number)")
                        .font(.caption)
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .background(isUser ? Color.green.opacity(0.3) : Color(.secondarySystemBackground))
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(isUser ? Color.green : Color.clear, lineWidth: 1)
                        )
                }
            }
        }
    }
}
