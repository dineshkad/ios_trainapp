// RailRadar/Core/Services/Onboard/RouteSnappingEngine.swift

import Foundation
import CoreLocation

struct SnappedPosition {
    let coordinate: CLLocationCoordinate2D
    let distanceAlongRoute: CLLocationDistance // meters from start
    let totalRouteDistance: CLLocationDistance // meters
}

final class RouteSnappingEngine {
    private let coordinates: [CLLocationCoordinate2D]

    init(route: RouteGeometry) {
        self.coordinates = route.coordinates.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
    }

    func snap(location: CLLocation) -> SnappedPosition? {
        guard !coordinates.isEmpty else { return nil }

        var bestDistance = CLLocationDistance.greatestFiniteMagnitude
        var bestIndex = 0

        for (index, coord) in coordinates.enumerated() {
            let point = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            let distance = location.distance(from: point)
            if distance < bestDistance {
                bestDistance = distance
                bestIndex = index
            }
        }

        let snappedCoord = coordinates[bestIndex]

        // Compute distance along route up to bestIndex
        var distanceAlong: CLLocationDistance = 0
        if bestIndex > 0 {
            for i in 1...bestIndex {
                let prev = CLLocation(latitude: coordinates[i-1].latitude, longitude: coordinates[i-1].longitude)
                let curr = CLLocation(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude)
                distanceAlong += prev.distance(from: curr)
            }
        }

        // Compute total route distance
        var total: CLLocationDistance = 0
        if coordinates.count > 1 {
            for i in 1..<coordinates.count {
                let prev = CLLocation(latitude: coordinates[i-1].latitude, longitude: coordinates[i-1].longitude)
                let curr = CLLocation(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude)
                total += prev.distance(from: curr)
            }
        }

        return SnappedPosition(
            coordinate: snappedCoord,
            distanceAlongRoute: distanceAlong,
            totalRouteDistance: total
        )
    }
}
