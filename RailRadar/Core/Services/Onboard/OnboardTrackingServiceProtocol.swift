// RailRadar/Core/Services/Onboard/OnboardTrackingService.swift

import Foundation
import Combine
import CoreLocation

final class OnboardTrackingService: NSObject, OnboardTrackingServiceProtocol {
    private let statusSubject = CurrentValueSubject<OnboardStatus, Never>(
        OnboardStatus(state: .notOnboard, distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil)
    )

    var statusPublisher: AnyPublisher<OnboardStatus, Never> {
        statusSubject.eraseToAnyPublisher()
    }

    private let locationManager: CLLocationManager
    private let geofenceManager: StationGeofenceManager
    private var snappingEngine: RouteSnappingEngine?

    private var currentJourney: Journey?
    private var currentRoute: RouteGeometry?
    private var currentTrain: Train?
    private var stations: [Station] = []

    override init() {
        self.locationManager = CLLocationManager()
        self.geofenceManager = StationGeofenceManager(locationManager: self.locationManager)
        super.init()
        self.locationManager.delegate = self
        self.geofenceManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.distanceFilter = 50
    }

    func startTracking(journey: Journey) {
        currentJourney = journey
        // For Phase 4, we assume you will call injectContext(train:route:stations:) before or after startTracking
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        currentJourney = nil
        currentRoute = nil
        currentTrain = nil
        snappingEngine = nil
        geofenceManager.clearGeofences()
        locationManager.stopUpdatingLocation()
        statusSubject.send(OnboardStatus(state: .notOnboard, distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil))
    }

    // Call this after loading train + route + stations for the journey
    func injectContext(train: Train, route: RouteGeometry, stations: [Station]) {
        self.currentTrain = train
        self.currentRoute = route
        self.stations = stations
        self.snappingEngine = RouteSnappingEngine(route: route)
        geofenceManager.configureGeofences(for: train.schedule, stations: stations)
    }

    private func handleLocationUpdate(_ location: CLLocation) {
        guard let engine = snappingEngine else { return }
        guard let snapped = engine.snap(location: location) else { return }

        let remaining = max(snapped.totalRouteDistance - snapped.distanceAlongRoute, 0)

        // For Phase 4, we won't compute real ETA; just show betweenStations.
        let status = OnboardStatus(
            state: .betweenStations,
            distanceRemaining: remaining,
            etaToNextStation: nil,
            etaToDestination: nil
        )
        statusSubject.send(status)
    }
}

extension OnboardTrackingService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        handleLocationUpdate(location)
    }
}

extension OnboardTrackingService: StationGeofenceManagerDelegate {
    func didEnterStation(code: String) {
        statusSubject.send(OnboardStatus(state: .atStation(code), distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil))
    }

    func didExitStation(code: String) {
        statusSubject.send(OnboardStatus(state: .betweenStations, distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil))
    }
}
