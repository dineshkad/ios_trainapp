//
//  PersistenceController.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Persistence/PersistenceController.swift

import Foundation
import SwiftData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    private init() {
        do {
            container = try ModelContainer(for:
                TrainEntity.self,
                StopScheduleEntity.self,
                JourneyEntity.self,
                PNRDetailsEntity.self,
                PassengerAllocationEntity.self,
                LiveStatusSnapshotEntity.self,
                RouteGeometryEntity.self
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    // MARK: - Journey helpers

    func fetchJourneys(context: ModelContext) throws -> [JourneyEntity] {
        let descriptor = FetchDescriptor<JourneyEntity>(sortBy: [SortDescriptor(\.journeyDate)])
        return try context.fetch(descriptor)
    }

    func saveJourney(_ journey: Journey, context: ModelContext) throws {
        let entity = JourneyEntity(
            id: journey.id,
            trainNumber: journey.trainNumber,
            trainName: journey.trainName,
            journeyDate: journey.journeyDate,
            boardingStationCode: journey.boardingStationCode,
            alightingStationCode: journey.alightingStationCode,
            distance: journey.distance,
            duration: journey.duration,
            createdAt: journey.createdAt,
            tierSourceRaw: journey.tierSource == .free ? "free" : "pro"
        )
        context.insert(entity)
        try context.save()
    }
}
