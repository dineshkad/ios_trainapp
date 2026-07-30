//
//  PassengerAllocationEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/PassengerAllocationEntity.swift

import Foundation
import SwiftData

@Model
final class PassengerAllocationEntity {
    var name: String?
    var coachCode: String
    var berthNumber: Int
    var berthType: String
    var travelClass: String
    var status: String

    init(
        name: String?,
        coachCode: String,
        berthNumber: Int,
        berthType: String,
        travelClass: String,
        status: String
    ) {
        self.name = name
        self.coachCode = coachCode
        self.berthNumber = berthNumber
        self.berthType = berthType
        self.travelClass = travelClass
        self.status = status
    }
}
