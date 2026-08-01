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
    
    
    // MARK: - PNR

    extension PNRDetails {
        init(dto: PNRStatusDTO) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"   // adjust per provider
            let date = formatter.date(from: dto.journeyDate) ?? Date()

            self.init(
                pnr: dto.pnr,
                trainNumber: dto.trainNumber,
                trainName: dto.trainName,
                boardingStation: dto.boardingStation,
                destinationStation: dto.destinationStation,
                journeyDate: date,
                passengers: dto.passengers.map { PassengerAllocation(dto: $0) }
            )
        }
    }

    extension PassengerAllocation {
        init(dto: PNRStatusDTO.Passenger) {
            let parsed = PNRStatusParser.parse(dto.currentStatus)
            self.init(
                name: dto.name ?? "Passenger \(dto.serialNumber)",
                coachCode: parsed.coachCode ?? "-",
                berthNumber: parsed.berthNumber ?? 0,
                berthType: parsed.berthType ?? "-",
                travelClass: "SL",   // TODO: derive from provider response when available
                status: parsed.status
            )
        }
    }

