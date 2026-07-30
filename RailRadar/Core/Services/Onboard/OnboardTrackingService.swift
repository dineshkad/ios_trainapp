//
//  OnboardTrackingService.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/Onboard/OnboardTrackingService.swift

import Foundation
import Combine

final class OnboardTrackingService: OnboardTrackingServiceProtocol {
    private let statusSubject = CurrentValueSubject<OnboardStatus, Never>(
        OnboardStatus(state: .notOnboard, distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil)
    )

    var statusPublisher: AnyPublisher<OnboardStatus, Never> {
        statusSubject.eraseToAnyPublisher()
    }

    private var currentJourney: Journey?

    func startTracking(journey: Journey) {
        currentJourney = journey
        // Phase 2: skeleton only. Later:
        // - Start CLLocationManager
        // - Snap to route
        // - Configure geofences
    }

    func stopTracking() {
        currentJourney = nil
        statusSubject.send(OnboardStatus(state: .notOnboard, distanceRemaining: nil, etaToNextStation: nil, etaToDestination: nil))
    }
}
