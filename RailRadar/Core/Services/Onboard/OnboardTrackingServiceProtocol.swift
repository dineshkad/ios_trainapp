//
//  OnboardTrackingServiceProtocol.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/Onboard/OnboardTrackingServiceProtocol.swift

import Foundation
import Combine

protocol OnboardTrackingServiceProtocol {
    var statusPublisher: AnyPublisher<OnboardStatus, Never> { get }

    func startTracking(journey: Journey)
    func stopTracking()
}
