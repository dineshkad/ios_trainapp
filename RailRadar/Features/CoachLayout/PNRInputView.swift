//
//  PNRInputView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/CoachLayout/PNRInputView.swift

import SwiftUI

struct PNRInputView: View {
    @Binding var pnrText: String
    let onLoad: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Enter PNR")
                .font(.headline)

            HStack {
                TextField("10-digit PNR", text: $pnrText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                Button("Load") {
                    onLoad()
                }
                .disabled(pnrText.count < 8) // simple guard
            }
        }
    }
}
