//
//  RouteGeometry.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/RouteGeometry.swift

import Foundation

struct RouteGeometry: Hashable {
    struct Coordinate: Hashable {
        let latitude: Double
        let longitude: Double
    }

    let trainNumber: String
    let coordinates: [Coordinate]
}
