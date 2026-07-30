//
//  Journey.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Models/Journey.swift

import Foundation

struct Journey: Identifiable, Hashable {
    enum TierSource {
        case free
        case pro
    }

    let id: UUID
    let trainNumber: String
    let trainName: String
    let journeyDate: Date
    let boardingStationCode: String?
    let alightingStationCode: String?
    let distance: Int
    let duration: TimeInterval
    let createdAt: Date
    let tierSource: TierSource

    init(
        id: UUID = UUID(),
        trainNumber: String,
        trainName: String,
        journeyDate: Date,
        boardingStationCode: String?,
        alightingStationCode: String?,
        distance: Int,
        duration: TimeInterval,
        createdAt: Date = Date(),
        tierSource: TierSource
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
        self.tierSource = tierSource
    }
}
