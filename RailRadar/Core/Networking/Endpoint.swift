//
//  Endpoint.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/Endpoint.swift

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        // add more as needed
    }
}
