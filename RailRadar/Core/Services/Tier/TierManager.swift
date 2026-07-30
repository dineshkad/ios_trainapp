//
//  TierManager.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Services/Tier/TierManager.swift

import Foundation

final class TierManager {
    static let shared = TierManager()

    private(set) var currentTier: UserTier = .free

    private init() { }

    // For later: wire to StoreKit. For now, allow manual override in debug.
    func setTier(_ tier: UserTier) {
        self.currentTier = tier
    }

    var maxSavedJourneys: Int {
        switch currentTier {
        case .free:
            return 10
        case .pro:
            return .max
        }
    }

    var minLiveRefreshInterval: TimeInterval {
        switch currentTier {
        case .free:
            return 30 // seconds
        case .pro:
            return 15 // seconds
        }
    }

    var canUseRadarMap: Bool {
        switch currentTier {
        case .free:
            return false
        case .pro:
            return true
        }
    }

    var canUseBackgroundOnboardTracking: Bool {
        switch currentTier {
        case .free:
            return false
        case .pro:
            return true
        }
    }

    var maxActivePNRJourneys: Int {
        switch currentTier {
        case .free:
            return 1
        case .pro:
            return .max
        }
    }
}
