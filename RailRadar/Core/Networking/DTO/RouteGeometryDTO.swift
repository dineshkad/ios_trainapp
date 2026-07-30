//
//  RouteGeometryDTO.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/DTO/RouteGeometryDTO.swift

import Foundation

struct RouteGeometryDTO: Decodable {
    struct Feature: Decodable {
        struct Geometry: Decodable {
            let type: String
            let coordinates: [[Double]]
        }
        struct Properties: Decodable {
            let trainNumber: String?
        }

        let type: String
        let geometry: Geometry
        let properties: Properties?
    }

    let type: String
    let features: [Feature]
}
