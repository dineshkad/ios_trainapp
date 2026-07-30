//
//  OnboardTrackingService.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

struct OnboardStatus {
    enum State { case notOnboard, betweenStations, atStation(String), arrivingSoon(String) }
    let state: State
    let distanceRemaining: Double?
    let etaToNextStation: Date?
    let etaToDestination: Date?
}

protocol OnboardTrackingServiceProtocol {
    func startTracking(journey: Journey)
    func stopTracking()
    var statusPublisher: AnyPublisher<OnboardStatus, Never> { get }
}
