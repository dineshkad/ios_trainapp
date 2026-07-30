//
//  DatePickerSheet.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Search/DatePickerSheet.swift

import SwiftUI

struct DatePickerSheet: View {
    @Binding var date: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Journey Date",
                    selection: $date,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()

                Button("Done") {
                    dismiss()
                }
                .padding()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
