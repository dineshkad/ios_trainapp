//
//  APIError.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/APIError.swift

import Foundation

enum APIError: Error, LocalizedError {
    case networkError(underlying: Error)
    case decodingError(underlying: Error)
    case serverError(code: String?, message: String?)
    case httpError(statusCode: Int)
    case rateLimitExceeded
    case unknown

    var errorDescription: String? {
        switch self {
        case .networkError(let underlying):
            return "Network error: \(underlying.localizedDescription)"
        case .decodingError(let underlying):
            return "Decoding error: \(underlying.localizedDescription)"
        case .serverError(let code, let message):
            return "Server error (\(code ?? "unknown")): \(message ?? "Unknown error")"
        case .httpError(let statusCode):
            return "HTTP error: \(statusCode)"
        case .rateLimitExceeded:
            return "Rate limit exceeded. Please try again later."
        case .unknown:
            return "Unknown error."
        }
    }
}
