//
//  PNRStatusParser.swift
//  
//
//  Created by Dinesh on 8/1/26.
//

//
//  PNRStatusParser.swift
//
//  Parses Indian Railways PNR status strings into PassengerAllocation values.
//  Provider-agnostic: all IR PNR sources return the same status format.
//

import Foundation

enum PNRStatusParser {

    struct ParsedStatus {
        let status: String          // CNF, RAC, WL, GNWL, etc.
        let coachCode: String?      // e.g. "S4"
        let berthNumber: Int?       // e.g. 32
        let berthType: String?      // LOWER, MIDDLE, UPPER, SIDE_LOWER, SIDE_UPPER
        let raw: String
    }

    private static let berthTypeMap: [String: String] = [
        "LB": "LOWER",
        "MB": "MIDDLE",
        "UB": "UPPER",
        "SL": "SIDE_LOWER",
        "SU": "SIDE_UPPER"
    ]

    /// Parses strings like "CNF / S4 / 32 / MB" or "WL / 12".
    static func parse(_ raw: String) -> ParsedStatus {
        let parts = raw
            .components(separatedBy: "/")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        guard let first = parts.first else {
            return ParsedStatus(status: "UNKNOWN", coachCode: nil, berthNumber: nil, berthType: nil, raw: raw)
        }

        let status = first.uppercased()

        // Confirmed/RAC format: "CNF / S4 / 32 / MB" (4 parts)
        if parts.count >= 3, let berthNumber = Int(parts[2]) {
            let coachCode = parts[1]
            let berthType = parts.count >= 4 ? (berthTypeMap[parts[3].uppercased()] ?? parts[3].uppercased()) : nil
            return ParsedStatus(status: status, coachCode: coachCode, berthNumber: berthNumber, berthType: berthType, raw: raw)
        }

        // Waitlist format: "WL / 12" (2 parts) — no allocation
        return ParsedStatus(status: status, coachCode: nil, berthNumber: nil, berthType: nil, raw: raw)
    }
}
