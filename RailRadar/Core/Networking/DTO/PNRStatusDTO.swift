//
//  PNRStatusDTO.swift
//
//  Provider-agnostic PNR response DTO. Adjust field names / CodingKeys
//  to match the chosen provider's JSON once a data source is decided.
//

import Foundation

struct PNRStatusDTO: Decodable {
    let pnr: String
    let trainNumber: String
    let trainName: String
    let boardingStation: String
    let destinationStation: String
    let journeyDate: String           // ISO or dd-MM-yyyy — normalized in mapping
    let passengers: [Passenger]

    struct Passenger: Decodable {
        let serialNumber: Int
        let bookingStatus: String     // e.g. "CNF / S4 / 32 / MB"
        let currentStatus: String
        let name: String?
    }
}
