//
//  PNRDetails.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/PNRDetails.swift

import Foundation

struct PNRDetails: Hashable {
    let pnr: String
    let journeyId: UUID
    let passengers: [PassengerAllocation]
}
