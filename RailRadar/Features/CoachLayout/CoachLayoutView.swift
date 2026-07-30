//
//  CoachLayoutView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/CoachLayout/CoachLayoutView.swift

import SwiftUI

struct CoachLayoutView: View {
    @StateObject private var viewModel: CoachLayoutViewModel

    init(pnrService: PNRServiceProtocol, coachLayoutService: CoachLayoutServiceProtocol) {
        _viewModel = StateObject(
            wrappedValue: CoachLayoutViewModel(
                pnrService: pnrService,
                coachLayoutService: coachLayoutService
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                PNRInputView(pnrText: $viewModel.pnrText) {
                    Task {
                        await viewModel.loadPNR()
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                if let details = viewModel.pnrDetails {
                    Text("PNR: \(details.pnr)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    if let passenger = details.passengers.first {
                        Text("Passenger 1 • Coach \(passenger.coachCode) • Berth \(passenger.berthNumber) (\(passenger.berthType))")
                            .font(.subheadline)
                    }
                }

                if let layout = viewModel.coachLayout {
                    // For now, derive coach codes from PNR passenger only
                    let coachCodes = viewModel.pnrDetails?.passengers.map { $0.coachCode } ?? []
                    CoachStripView(
                        coachCodes: Array(Set(coachCodes)).sorted(),
                        selectedCoachCode: viewModel.selectedCoachCode
                    ) { code in
                        if let passenger = viewModel.pnrDetails?.passengers.first(where: { $0.coachCode == code }) {
                            viewModel.selectCoach(code: code, typeHint: passenger.travelClass)
                        } else {
                            viewModel.selectCoach(code: code, typeHint: nil)
                        }
                    }

                    CoachDetailView(
                        layout: layout,
                        userBerthNumber: viewModel.pnrDetails?.passengers.first?.berthNumber
                    )
                } else {
                    Text("Enter a PNR to see coach layout.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Coach Layout")
        .navigationBarTitleDisplayMode(.inline)
    }
}
