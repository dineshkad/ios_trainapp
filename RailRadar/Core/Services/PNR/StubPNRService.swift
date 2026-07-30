//
//  StubPNRService.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/PNR/StubPNRService.swift

import Foundation

final class StubPNRService: PNRServiceProtocol {
    func fetchPNR(_ pnr: String) async throws -> PNRDetails {
        // Stub implementation for development/testing.
        let journeyId = UUID()
        let passenger = PassengerAllocation(
            name: "Passenger 1",
            coachCode: "S3",
            berthNumber: 21,
            berthType: "LOWER",
            travelClass: "SL",
            status: "CNF"
        )
        return PNRDetails(pnr: pnr, journeyId: journeyId, passengers: [passenger])
    }
}

