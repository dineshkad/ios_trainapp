//
//  StopSchedule.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/StopSchedule.swift

import Foundation

struct StopSchedule: Hashable {
    let stationCode: String
    let stationName: String
    let arrival: String?   // "HH:mm"
    let departure: String? // "HH:mm"
    let dayOffset: Int     // 1 = day 1, 2 = day 2, etc.
    let distance: Int
    let platform: Int?
}
