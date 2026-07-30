//
//  PNRDetailsEntity.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Persistence/Models/PNRDetailsEntity.swift

import Foundation
import SwiftData

@Model
final class PNRDetailsEntity {
    @Attribute(.unique) var pnr: String
    var journeyId: UUID

    @Relationship(deleteRule: .cascade) var passengers: [PassengerAllocationEntity]

    init(pnr: String, journeyId: UUID, passengers: [PassengerAllocationEntity]) {
        self.pnr = pnr
        self.journeyId = journeyId
        self.passengers = passengers
    }
}
