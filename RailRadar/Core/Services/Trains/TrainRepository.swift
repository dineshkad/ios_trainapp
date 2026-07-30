//
//  TrainRepository.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/Trains/TrainRepository.swift

import Foundation
import SwiftData

final class TrainRepository: TrainRepositoryProtocol {
    private let apiClient: RailRadarAPIClient
    private let persistence: PersistenceController
    private let tierManager: TierManager

    init(
        apiClient: RailRadarAPIClient,
        persistence: PersistenceController = .shared,
        tierManager: TierManager = .shared
    ) {
        self.apiClient = apiClient
        self.persistence = persistence
        self.tierManager = tierManager
    }

    func getSchedule(for trainNumber: String) async throws -> Train {
        let dto = try await apiClient.getTrainSchedule(number: trainNumber)
        return DTOToDomainMapping.train(from: dto)
    }

    func getLiveStatus(for trainNumber: String, journeyDate: Date?) async throws -> LiveStatusSnapshot {
        let dto = try await apiClient.getLiveStatus(number: trainNumber, journeyDate: journeyDate)
        return DTOToDomainMapping.liveStatusSnapshot(from: dto, journeyDate: journeyDate)
    }

    func searchTrains(by query: String) async throws -> [Train] {
        // For Phase 2, just return empty; later integrate lookup + fuzzy search.
        return []
    }

    func getTrainsBetween(from: String, to: String) async throws -> [Train] {
        // For Phase 2, return empty; map TrainsBetweenDTO -> Train later.
        return []
    }

    func saveJourney(_ journey: Journey) throws {
        let context = persistence.container.mainContext
        let existing = try persistence.fetchJourneys(context: context)

        if existing.count >= tierManager.maxSavedJourneys {
            throw NSError(
                domain: "TrainRepository",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Maximum saved journeys reached for current tier."]
            )
        }

        try persistence.saveJourney(journey, context: context)
    }

    func fetchJourneys() throws -> [Journey] {
        let context = persistence.container.mainContext
        let entities = try persistence.fetchJourneys(context: context)

        // Minimal mapping back to domain model for now.
        return entities.map { entity in
            Journey(
                id: entity.id,
                trainNumber: entity.trainNumber,
                trainName: entity.trainName,
                journeyDate: entity.journeyDate,
                boardingStationCode: entity.boardingStationCode,
                alightingStationCode: entity.alightingStationCode,
                distance: entity.distance,
                duration: entity.duration,
                createdAt: entity.createdAt,
                tierSource: entity.tierSourceRaw == "pro" ? .pro : .free
            )
        }
    }
}

