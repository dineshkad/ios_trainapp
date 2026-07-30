//
//  Station.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Models/Station.swift

import Foundation

struct Station: Identifiable, Hashable {
    let id: UUID
    let code: String
    let name: String
    let city: String?
    let state: String?
    let latitude: Double?
    let longitude: Double?

    init(
        id: UUID = UUID(),
        code: String,
        name: String,
        city: String? = nil,
        state: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
    }
}
