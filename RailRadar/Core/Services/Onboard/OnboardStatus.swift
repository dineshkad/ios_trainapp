//
//  OnboardStatus.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Services/Onboard/OnboardStatus.swift

import Foundation

struct OnboardStatus {
    enum State {
        case notOnboard
        case betweenStations
        case atStation(String) // station code
        case arrivingSoon(String) // station code
    }

    let state: State
    let distanceRemaining: Double? // meters
    let etaToNextStation: Date?
    let etaToDestination: Date?
}
