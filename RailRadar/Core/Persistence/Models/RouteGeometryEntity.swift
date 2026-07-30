//
//  RouteGeometryEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/RouteGeometryEntity.swift

import Foundation
import SwiftData

@Model
final class RouteGeometryEntity {
    var trainNumber: String
    // Store coordinates as JSON Data in v1
    var coordinatesData: Data

    init(trainNumber: String, coordinatesData: Data) {
        self.trainNumber = trainNumber
        self.coordinatesData = coordinatesData
    }
}
