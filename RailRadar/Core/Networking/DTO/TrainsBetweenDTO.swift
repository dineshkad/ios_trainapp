//
//  TrainsBetweenDTO.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/DTO/TrainsBetweenDTO.swift

import Foundation

struct TrainsBetweenDTO: Decodable {
    let trainNumber: String
    let trainName: String
    let type: String?
    let departure: String?
    let arrival: String?
    let duration: String?
}
