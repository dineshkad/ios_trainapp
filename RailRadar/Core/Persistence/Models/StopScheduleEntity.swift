//
//  StopScheduleEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/StopScheduleEntity.swift

import Foundation
import SwiftData

@Model
final class StopScheduleEntity {
    var stationCode: String
    var stationName: String
    var arrival: String?
    var departure: String?
    var dayOffset: Int
    var distance: Int
    var platform: Int?

    init(
        stationCode: String,
        stationName: String,
        arrival: String?,
        departure: String?,
        dayOffset: Int,
        distance: Int,
        platform: Int?
    ) {
        self.stationCode = stationCode
        self.stationName = stationName
        self.arrival = arrival
        self.departure = departure
        self.dayOffset = dayOffset
        self.distance = distance
        self.platform = platform
    }
}
