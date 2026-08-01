//
//  CoachLayoutView.swift
//

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

                if viewModel.isLoading {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Fetching PNR status…")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                if let details = viewModel.pnrDetails {
                    PNRJourneyHeader(details: details)
                    PassengerListView(viewModel: viewModel)
                }

                if let layout = viewModel.coachLayout {
                    // Only coaches that hold at least one allocated passenger
                    let coachCodes = viewModel.pnrDetails?.passengers
                        .filter { $0.hasAllocation }
                        .map { $0.coachCode } ?? []
                    CoachStripView(
                        coachCodes: Array(Set(coachCodes)).sorted(),
                        selectedCoachCode: viewModel.selectedCoachCode
                    ) { code in
                        if let passenger = viewModel.pnrDetails?.passengers.first(where: {
                            $0.coachCode == code && $0.hasAllocation
                        }) {
                            viewModel.selectPassenger(passenger)
                        } else {
                            viewModel.selectCoach(code: code, typeHint: nil)
                        }
                    }

                    CoachDetailView(
                        layout: layout,
                        userBerthNumber: viewModel.selectedPassenger?.berthNumber
                    )
                } else if viewModel.pnrDetails != nil && !viewModel.isLoading {
                    Text("No confirmed berths yet — all passengers are waitlisted.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else if !viewModel.isLoading {
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

// MARK: - Journey Header

private struct PNRJourneyHeader: View {
    let details: PNRDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(details.trainNumber) • \(details.trainName)")
                .font(.headline)
            Text("\(details.boardingStation) → \(details.destinationStation)")
                .font(.subheadline)
            Text(details.journeyDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Passenger List

private struct PassengerListView: View {
    @ObservedObject var viewModel: CoachLayoutViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Passengers")
                .font(.subheadline)
                .fontWeight(.semibold)

            ForEach(Array((viewModel.pnrDetails?.passengers ?? []).enumerated()), id: \.element) { index, passenger in
                PassengerRowView(
                    index: index + 1,
                    passenger: passenger,
                    isSelected: passenger == viewModel.selectedPassenger
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectPassenger(passenger)
                }
            }
        }
    }
}

private struct PassengerRowView: View {
    let index: Int
    let passenger: PassengerAllocation
    let isSelected: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(passenger.name ?? "Passenger \(index)")
                    .font(.subheadline)
                if passenger.hasAllocation {
                    Text("Coach \(passenger.coachCode) • Berth \(passenger.berthNumber) (\(passenger.berthType))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("No berth allocated yet")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            StatusBadge(status: passenger.status)
        }
        .padding(10)
        .background(isSelected ? Color.accentColor.opacity(0.12) : Color(.secondarySystemBackground))
        .cornerRadius(8)
        .opacity(passenger.hasAllocation ? 1 : 0.6)
    }
}

private struct StatusBadge: View {
    let status: String

    private var color: Color {
        switch status.uppercased() {
        case "CNF": return .green
        case "RAC": return .orange
        default:    return .red   // WL, GNWL, etc.
        }
    }

    var body: some View {
        Text(status.uppercased())
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(6)
    }
}
