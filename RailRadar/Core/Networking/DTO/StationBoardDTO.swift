//
//  StationBoardDTO.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/DTO/StationBoardDTO.swift

import Foundation

struct StationBoardDTO: Decodable {
    struct Station: Decodable {
        let code: String
        let name: String
    }

    struct TrainInfo: Decodable {
        let trainNumber: String
        let trainName: String
        let direction: String?
        let scheduledTime: String?
        let expectedTime: String?
        let delayMinutes: Int?
    }

    let station: Station
    let trains: [TrainInfo]
}
