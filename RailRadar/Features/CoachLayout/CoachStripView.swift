//
//  CoachStripView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/CoachLayout/CoachStripView.swift

import SwiftUI

struct CoachStripView: View {
    let coachCodes: [String]
    let selectedCoachCode: String?
    let onSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(coachCodes, id: \.self) { code in
                    Button {
                        onSelect(code)
                    } label: {
                        Text(code)
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(code == selectedCoachCode ? Color.blue.opacity(0.2) : Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
