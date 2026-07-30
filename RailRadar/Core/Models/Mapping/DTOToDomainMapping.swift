//
//  DTOToDomainMapping.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/Mapping/DTOToDomainMapping.swift

import Foundation

enum DTOToDomainMapping {

    static func train(from dto: TrainScheduleDTO) -> Train {
        let stops = dto.stops.map { stopDTO in
            StopSchedule(
                stationCode: stopDTO.stationCode,
                stationName: stopDTO.stationName,
                arrival: stopDTO.arrival,
                departure: stopDTO.departure,
                dayOffset: stopDTO.dayOffset,
                distance: stopDTO.distance,
                platform: stopDTO.platform
            )
        }

        return Train(
            number: dto.trainNumber,
            name: dto.trainName,
            type: dto.type,
            fromStationCode: dto.from.code,
            toStationCode: dto.to.code,
            schedule: stops,
            isFavorite: false
        )
    }

    static func liveStatusSnapshot(from dto: LiveStatusDTO, journeyDate: Date?) -> LiveStatusSnapshot {
        let perStop = dto.perStopStatus.map { stopDTO in
            LiveStatusSnapshot.StopStatus(
                stationCode: stopDTO.stationCode,
                arrival: stopDTO.arrival,
                departure: stopDTO.departure,
                actualArrival: stopDTO.actualArrival,
                actualDeparture: stopDTO.actualDeparture,
                delay: stopDTO.delay,
                status: stopDTO.status,
                platform: stopDTO.platform
            )
        }

        return LiveStatusSnapshot(
            trainNumber: dto.trainNumber,
            journeyDate: journeyDate,
            timestamp: Date(),
            currentStationCode: dto.currentStationCode,
            currentStationName: dto.currentStationName,
            delayMinutes: dto.delayMinutes,
            perStopStatus: perStop
        )
    }

    static func routeGeometry(from dto: RouteGeometryDTO, trainNumber: String) -> RouteGeometry? {
        guard let feature = dto.features.first else { return nil }
        let coords = feature.geometry.coordinates.map { pair -> RouteGeometry.Coordinate in
            // GeoJSON: [lon, lat]
            let lon = pair[0]
            let lat = pair[1]
            return RouteGeometry.Coordinate(latitude: lat, longitude: lon)
        }
        return RouteGeometry(trainNumber: trainNumber, coordinates: coords)
    }
}
