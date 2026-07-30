//
//  Train.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Models/Train.swift

import Foundation

struct Train: Identifiable, Hashable {
    let id: UUID
    let number: String
    let name: String
    let type: String?
    let fromStationCode: String
    let toStationCode: String
    let schedule: [StopSchedule]
    let isFavorite: Bool

    init(
        id: UUID = UUID(),
        number: String,
        name: String,
        type: String?,
        fromStationCode: String,
        toStationCode: String,
        schedule: [StopSchedule],
        isFavorite: Bool = false
    ) {
        self.id = id
        self.number = number
        self.name = name
        self.type = type
        self.fromStationCode = fromStationCode
        self.toStationCode = toStationCode
        self.schedule = schedule
        self.isFavorite = isFavorite
    }
}
