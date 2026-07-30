//
//  JourneyEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/JourneyEntity.swift

import Foundation
import SwiftData

@Model
final class JourneyEntity {
    @Attribute(.unique) var id: UUID
    var trainNumber: String
    var trainName: String
    var journeyDate: Date
    var boardingStationCode: String?
    var alightingStationCode: String?
    var distance: Int
    var duration: TimeInterval
    var createdAt: Date
    var tierSourceRaw: String

    init(
        id: UUID,
        trainNumber: String,
        trainName: String,
        journeyDate: Date,
        boardingStationCode: String?,
        alightingStationCode: String?,
        distance: Int,
        duration: TimeInterval,
        createdAt: Date,
        tierSourceRaw: String
    ) {
        self.id = id
        self.trainNumber = trainNumber
        self.trainName = trainName
        self.journeyDate = journeyDate
        self.boardingStationCode = boardingStationCode
        self.alightingStationCode = alightingStationCode
        self.distance = distance
        self.duration = duration
        self.createdAt = createdAt
        self.tierSourceRaw = tierSourceRaw
    }
}
