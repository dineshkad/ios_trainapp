//
//  CoachLayoutViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/CoachLayout/CoachLayoutViewModel.swift

import Foundation
import Combine

final class CoachLayoutViewModel: ObservableObject {
    @Published var pnrText: String = ""
    @Published var pnrDetails: PNRDetails?
    @Published var selectedCoachCode: String?
    @Published var coachLayout: CoachLayout?
    @Published var errorMessage: String?

    private let pnrService: PNRServiceProtocol
    private let coachLayoutService: CoachLayoutServiceProtocol

    init(pnrService: PNRServiceProtocol, coachLayoutService: CoachLayoutServiceProtocol) {
        self.pnrService = pnrService
        self.coachLayoutService = coachLayoutService
    }

    @MainActor
    func loadPNR() async {
        guard !pnrText.isEmpty else { return }
        errorMessage = nil

        do {
            let details = try await pnrService.fetchPNR(pnrText)
            self.pnrDetails = details

            // Auto-select first passenger's coach if available
            if let firstPassenger = details.passengers.first {
                selectCoach(code: firstPassenger.coachCode, typeHint: firstPassenger.travelClass)
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }

    func selectCoach(code: String, typeHint: String?) {
        selectedCoachCode = code
        let type = typeHint ?? code
        coachLayout = coachLayoutService.layout(for: type)
    }
}
