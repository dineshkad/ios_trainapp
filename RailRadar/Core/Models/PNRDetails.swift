//
//  PNRDetails.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/PNRDetails.swift

import Foundation

struct PNRDetails: Codable, Equatable {
    let pnr: String
    let trainNumber: String
    let trainName: String
    let boardingStation: String
    let destinationStation: String
    let journeyDate: Date
    let passengers: [PassengerAllocation]
}
