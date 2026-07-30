// RailRadar/Core/Services/Trains/TrainRepository.swift

import Foundation
import SwiftData

final class TrainRepository: TrainRepositoryProtocol {
    private let apiClient: RailRadarAPIClient
    private let persistence: PersistenceController
    private let tierManager: TierManager

    private var cachedLookup: TrainLookupDTO?

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
        let lookup = try await getLookup()
        let lowercased = query.lowercased()

        let matches = lookup.filter { (number, name) in
            number.contains(query) || name.lowercased().contains(lowercased)
        }

        // For Phase 4, return lightweight Train objects with just number/name.
        return matches.map { (number, name) in
            Train(
                number: number,
                name: name,
                type: nil,
                fromStationCode: "",
                toStationCode: "",
                schedule: [],
                isFavorite: false
            )
        }
    }

    func getTrainsBetween(from: String, to: String) async throws -> [Train] {
        // Still stubbed for now; can be implemented later.
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

    // MARK: - Lookup

    private func getLookup() async throws -> TrainLookupDTO {
        if let cached = cachedLookup {
            return cached
        }
        let lookup = try await apiClient.getTrainLookup()
        cachedLookup = lookup
        return lookup
    }
}
