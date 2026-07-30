//
//  RailRadarEnvelope.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/RailRadarEnvelope.swift

import Foundation

struct RailRadarEnvelope<T: Decodable>: Decodable {
    let success: Bool
    let data: T?
    let error: RailRadarErrorPayload?
    let meta: RailRadarMeta
}

struct RailRadarMeta: Decodable {
    let traceId: String
    let timestamp: String
    let executionTime: Int
    let source: String
}

// Placeholder for error payload; exact schema TBD from real responses.
struct RailRadarErrorPayload: Decodable {
    let code: String?
    let message: String?
}
