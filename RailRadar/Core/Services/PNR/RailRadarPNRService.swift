//
//  RailRadarPNRService.swift
//

import Foundation

enum PNRConfig {
    // TODO: Set once a PNR provider is chosen, e.g. "v1/pnr".
    static var endpointPath: String? = nil
}

enum PNRError: Error, Equatable {
    case providerNotConfigured
}

final class RailRadarPNRService: PNRServiceProtocol {

    private let api: RailRadarAPIClient

    init(api: RailRadarAPIClient) {
        self.api = api
    }

    func fetchPNR(_ pnr: String) async throws -> PNRDetails {
        let dto = try await api.getPNRStatus(pnr: pnr)
        return PNRDetails(dto: dto)
    }
}
