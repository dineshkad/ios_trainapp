//
//  OnboardTrackingServiceProtocol.swift
//

import Foundation
import Combine

protocol OnboardTrackingServiceProtocol {
    var statusPublisher: AnyPublisher<OnboardStatus, Never> { get }

    func startTracking(journey: Journey)
    func stopTracking()
}
