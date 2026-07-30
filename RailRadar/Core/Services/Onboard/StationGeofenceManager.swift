// RailRadar/Core/Services/Onboard/StationGeofenceManager.swift

import Foundation
import CoreLocation

protocol StationGeofenceManagerDelegate: AnyObject {
    func didEnterStation(code: String)
    func didExitStation(code: String)
}

final class StationGeofenceManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager
    weak var delegate: StationGeofenceManagerDelegate?

    private var stationCoordinates: [String: CLLocationCoordinate2D] = [:]

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    func configureGeofences(for stops: [StopSchedule], stations: [Station]) {
        // Build map of stationCode -> coordinate
        var map: [String: CLLocationCoordinate2D] = [:]
        for station in stations {
            if let lat = station.latitude, let lon = station.longitude {
                map[station.code] = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
        }
        stationCoordinates = map

        // Remove existing regions
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }

        // Add new regions for stops with coordinates
        for stop in stops {
            guard let coord = stationCoordinates[stop.stationCode] else { continue }
            let region = CLCircularRegion(
                center: coord,
                radius: 300, // meters
                identifier: stop.stationCode
            )
            region.notifyOnEntry = true
            region.notifyOnExit = true
            locationManager.startMonitoring(for: region)
        }
    }

    func clearGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        delegate?.didEnterStation(code: region.identifier)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        delegate?.didExitStation(code: region.identifier)
    }
}
