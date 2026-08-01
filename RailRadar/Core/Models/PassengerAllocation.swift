//
//  PassengerAllocation.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/PassengerAllocation.swift

import Foundation

struct PassengerAllocation: Hashable, Codable{
    let name: String?
    let coachCode: String
    let berthNumber: Int
    let berthType: String // e.g., LOWER, MIDDLE, UPPER, SIDE_LOWER
    let travelClass: String // e.g., SL, 3A, 2A, CC
    let status: String // e.g., CNF, RAC, WL
}

extension PassengerAllocation {
    /// True when the passenger has a confirmed/RAC berth to show on the layout.
    var hasAllocation: Bool { berthNumber > 0 && coachCode != "-" }
}
