//
//  RailRadarAPIClient.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Networking/RailRadarAPIClient.swift

import Foundation

final class RailRadarAPIClient {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getTrainSchedule(number: String) async throws -> TrainScheduleDTO {
        let endpoint = Endpoint(
            path: "v1/trains/\(number)",
            method: .get,
            queryItems: nil
        )
        return try await networkClient.request(endpoint, as: TrainScheduleDTO.self)
    }

    func getLiveStatus(number: String, journeyDate: Date?) async throws -> LiveStatusDTO {
        var queryItems: [URLQueryItem]? = nil
        if let journeyDate = journeyDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: journeyDate)
            queryItems = [URLQueryItem(name: "date", value: dateString)]
        }

        let endpoint = Endpoint(
            path: "v1/trains/\(number)/live",
            method: .get,
            queryItems: queryItems
        )
        return try await networkClient.request(endpoint, as: LiveStatusDTO.self)
    }

    func getTrainsBetween(from: String, to: String) async throws -> [TrainsBetweenDTO] {
        let endpoint = Endpoint(
            path: "v1/trains/between/\(from)/\(to)",
            method: .get,
            queryItems: nil
        )
        return try await networkClient.request(endpoint, as: [TrainsBetweenDTO].self)
    }

    func getStationBoard(code: String) async throws -> StationBoardDTO {
        let endpoint = Endpoint(
            path: "v1/stations/\(code)/trains",
            method: .get,
            queryItems: nil
        )
        return try await networkClient.request(endpoint, as: StationBoardDTO.self)
    }

    func getRoute(number: String) async throws -> RouteGeometryDTO {
        let endpoint = Endpoint(
            path: "v1/trains/\(number)/route",
            method: .get,
            queryItems: nil
        )
        return try await networkClient.request(endpoint, as: RouteGeometryDTO.self)
    }

    func getTrainLookup() async throws -> TrainLookupDTO {
        let endpoint = Endpoint(
            path: "v1/lookup/trains",
            method: .get,
            queryItems: nil
        )
        return try await networkClient.request(endpoint, as: TrainLookupDTO.self)
    }
}
