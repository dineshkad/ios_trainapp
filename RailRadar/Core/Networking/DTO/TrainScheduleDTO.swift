//
//  TrainScheduleDTO.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/DTO/TrainScheduleDTO.swift

import Foundation

struct TrainScheduleDTO: Decodable {
    struct StationInfo: Decodable {
        let code: String
        let name: String
    }

    struct Stop: Decodable {
        let stationCode: String
        let stationName: String
        let arrival: String?
        let departure: String?
        let dayOffset: Int
        let distance: Int
        let platform: Int?
    }

    let trainNumber: String
    let trainName: String
    let type: String?
    let from: StationInfo
    let to: StationInfo
    let stops: [Stop]
}
