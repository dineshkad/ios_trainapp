//
//  LiveStatusDTO.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/DTO/LiveStatusDTO.swift

import Foundation

struct LiveStatusDTO: Decodable {
    struct PerStopStatus: Decodable {
        let stationCode: String
        let arrival: String?
        let departure: String?
        let actualArrival: String?
        let actualDeparture: String?
        let delay: Int?
        let status: String?
        let platform: Int?
    }

    let trainNumber: String
    let journeyDate: String?
    let currentStationCode: String?
    let currentStationName: String?
    let delayMinutes: Int?
    let perStopStatus: [PerStopStatus]
}
