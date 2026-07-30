//
//  TrainEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/TrainEntity.swift

import Foundation
import SwiftData

@Model
final class TrainEntity {
    @Attribute(.unique) var number: String
    var name: String
    var type: String?
    var fromStationCode: String
    var toStationCode: String
    var isFavorite: Bool

    @Relationship(deleteRule: .cascade) var stops: [StopScheduleEntity]

    init(
        number: String,
        name: String,
        type: String?,
        fromStationCode: String,
        toStationCode: String,
        isFavorite: Bool,
        stops: [StopScheduleEntity]
    ) {
        self.number = number
        self.name = name
        self.type = type
        self.fromStationCode = fromStationCode
        self.toStationCode = toStationCode
        self.isFavorite = isFavorite
        self.stops = stops
    }
}
