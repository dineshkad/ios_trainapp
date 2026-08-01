//
//  FallbackPNRService.swift
//

import Foundation

final class FallbackPNRService: PNRServiceProtocol {

    private let primary: PNRServiceProtocol
    private let fallback: PNRServiceProtocol

    var logsSource = true

    init(primary: PNRServiceProtocol, fallback: PNRServiceProtocol = StubPNRService()) {
        self.primary = primary
        self.fallback = fallback
    }

    func fetchPNR(_ pnr: String) async throws -> PNRDetails {
        do {
            let details = try await primary.fetchPNR(pnr)
            if logsSource { print("[PNR] served by LIVE service") }
            return details
        } catch {
            if logsSource { print("[PNR] live failed (\(error.localizedDescription)); serving STUB") }
            return try await fallback.fetchPNR(pnr)
        }
    }
}
