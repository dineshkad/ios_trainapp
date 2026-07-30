//
//  NetworkClient.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/NetworkClient.swift

import Foundation

final class NetworkClient {
    private let baseURL: URL
    private let urlSession: URLSession
    private let apiKey: String

    init(baseURL: URL, apiKey: String, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.urlSession = urlSession
    }

    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryItems

        guard let url = components?.url else {
            throw APIError.unknown
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }

            if httpResponse.statusCode == 429 {
                throw APIError.rateLimitExceeded
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                throw APIError.httpError(statusCode: httpResponse.statusCode)
            }

            do {
                let decoded = try JSONDecoder().decode(RailRadarEnvelope<T>.self, from: data)
                if decoded.success, let payload = decoded.data {
                    return payload
                } else {
                    let err = decoded.error
                    throw APIError.serverError(code: err?.code, message: err?.message)
                }
            } catch let decodingError {
                throw APIError.decodingError(underlying: decodingError)
            }

        } catch let networkError {
            throw APIError.networkError(underlying: networkError)
        }
    }
}
