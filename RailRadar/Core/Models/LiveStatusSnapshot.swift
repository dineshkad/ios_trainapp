//
//  LiveStatusSnapshot.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/LiveStatusSnapshot.swift

import Foundation

struct LiveStatusSnapshot: Hashable {
    struct StopStatus: Hashable {
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
    let journeyDate: Date?
    let timestamp: Date
    let currentStationCode: String?
    let currentStationName: String?
    let delayMinutes: Int?
    let perStopStatus: [StopStatus]
}
