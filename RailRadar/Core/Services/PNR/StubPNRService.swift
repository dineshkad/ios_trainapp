//
//  StubPNRService.swift
//
//  Development/testing stub with realistic multi-passenger data.
//  Covers CNF, RAC, and WL states so Coach Layout handles all cases.
//

import Foundation

final class StubPNRService: PNRServiceProtocol {

    enum StubError: Error { case invalidPNR }

    func fetchPNR(_ pnr: String) async throws -> PNRDetails {
        // Simulate network latency
        try await Task.sleep(nanoseconds: 500_000_000)

        guard pnr.count == 10, pnr.allSatisfy(\.isNumber) else {
            throw StubError.invalidPNR
        }

        let passengers: [PassengerAllocation] = [
            PassengerAllocation(
                name: "Passenger 1",
                coachCode: "S4",
                berthNumber: 32,
                berthType: "MIDDLE",
                travelClass: "SL",
                status: "CNF"
            ),
            PassengerAllocation(
                name: "Passenger 2",
                coachCode: "S4",
                berthNumber: 31,
                berthType: "LOWER",
                travelClass: "SL",
                status: "CNF"
            ),
            PassengerAllocation(
                name: "Passenger 3",
                coachCode: "S4",
                berthNumber: 35,
                berthType: "SIDE_LOWER",
                travelClass: "SL",
                status: "RAC"
            ),
            PassengerAllocation(
                name: "Passenger 4",
                coachCode: "-",
                berthNumber: 0,
                berthType: "-",
                travelClass: "SL",
                status: "WL"
            )
        ]

        return PNRDetails(
            pnr: pnr,
            trainNumber: "12627",
            trainName: "Karnataka Express",
            boardingStation: "SBC",
            destinationStation: "NDLS",
            journeyDate: Date().addingTimeInterval(86400 * 3),
            passengers: passengers
        )
    }
}
