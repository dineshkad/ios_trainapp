//
//  Endpoint.swift
//

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    init(path: String, method: HTTPMethod = .get, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }

    // MARK: - Endpoints

    /// PNR status lookup. Path prefix is configurable until a provider is chosen.
    static func pnrStatus(pnr: String) -> Endpoint {
        let base = PNRConfig.endpointPath ?? "/pnr"
        return Endpoint(path: "\(base)/\(pnr)")
    }
}
