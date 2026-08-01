//
//  CoachLayoutViewModel.swift
//

import Foundation
import Combine

final class CoachLayoutViewModel: ObservableObject {
    @Published var pnrText: String = ""
    @Published var pnrDetails: PNRDetails?
    @Published var selectedCoachCode: String?
    @Published var selectedPassenger: PassengerAllocation?
    @Published var coachLayout: CoachLayout?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let pnrService: PNRServiceProtocol
    private let coachLayoutService: CoachLayoutServiceProtocol

    init(pnrService: PNRServiceProtocol, coachLayoutService: CoachLayoutServiceProtocol) {
        self.pnrService = pnrService
        self.coachLayoutService = coachLayoutService
    }

    /// PNRs are exactly 10 digits.
    var isPNRValid: Bool {
        pnrText.count == 10 && pnrText.allSatisfy(\.isNumber)
    }

    @MainActor
    func loadPNR() async {
        guard isPNRValid else {
            errorMessage = "Enter a valid 10-digit PNR number."
            return
        }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let details = try await pnrService.fetchPNR(pnrText)
            self.pnrDetails = details

            // Auto-select the first passenger WITH a berth (skip WL).
            if let firstAllocated = details.passengers.first(where: { $0.hasAllocation }) {
                selectPassenger(firstAllocated)
            } else {
                // Everyone is WL — nothing to show on the layout.
                selectedPassenger = nil
                selectedCoachCode = nil
                coachLayout = nil
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.pnrDetails = nil
        }
    }

    /// Tapping a passenger row highlights their berth on the layout.
    func selectPassenger(_ passenger: PassengerAllocation) {
        guard passenger.hasAllocation else { return }
        selectedPassenger = passenger
        selectCoach(code: passenger.coachCode, typeHint: passenger.travelClass)
    }

    func selectCoach(code: String, typeHint: String?) {
        selectedCoachCode = code
        let type = typeHint ?? code
        coachLayout = coachLayoutService.layout(for: type)
    }
}
