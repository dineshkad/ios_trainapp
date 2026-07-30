//
//  LiveStatusSnapshotEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/LiveStatusSnapshotEntity.swift

import Foundation
import SwiftData

@Model
final class LiveStatusSnapshotEntity {
    var trainNumber: String
    var journeyDate: Date?
    var timestamp: Date
    var currentStationCode: String?
    var currentStationName: String?
    var delayMinutes: Int?

    // For simplicity, store perStopStatus as JSON Data in v1
    var perStopStatusData: Data?

    init(
        trainNumber: String,
        journeyDate: Date?,
        timestamp: Date,
        currentStationCode: String?,
        currentStationName: String?,
        delayMinutes: Int?,
        perStopStatusData: Data?
    ) {
        self.trainNumber = trainNumber
        self.journeyDate = journeyDate
        self.timestamp = timestamp
        self.currentStationCode = currentStationCode
        self.currentStationName = currentStationName
        self.delayMinutes = delayMinutes
        self.perStopStatusData = perStopStatusData
    }
}
