//
//  SleeperCoachLayout.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/Coach/CoachLayout.swift

import Foundation

enum BerthType: String {
    case lower
    case middle
    case upper
    case sideLower
    case sideUpper
    case seat
}

struct CoachBerth {
    let number: Int
    let type: BerthType
}

struct CoachLayout {
    let code: String
    let berths: [CoachBerth]
}
