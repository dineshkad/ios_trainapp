//
//  CoachLayoutService.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/Coach/CoachLayoutService.swift

import Foundation

final class CoachLayoutService: CoachLayoutServiceProtocol {
    func layout(for coachType: String) -> CoachLayout {
        switch coachType.uppercased() {
        case "SL", "SLEEPER":
            return CoachLayout(code: coachType, berths: Self.sleeperLayout())
        case "3A", "AC3":
            return CoachLayout(code: coachType, berths: Self.threeACLayout())
        case "2A", "AC2":
            return CoachLayout(code: coachType, berths: Self.twoACLayout())
        case "CC", "CHAIR":
            return CoachLayout(code: coachType, berths: Self.chairCarLayout())
        default:
            return CoachLayout(code: coachType, berths: [])
        }
    }

    private static func sleeperLayout() -> [CoachBerth] {
        var berths: [CoachBerth] = []
        var number = 1
        for _ in 1...8 { // 8 bays
            for _ in 1...3 {
                berths.append(CoachBerth(number: number, type: .lower)); number += 1
                berths.append(CoachBerth(number: number, type: .middle)); number += 1
                berths.append(CoachBerth(number: number, type: .upper)); number += 1
            }
            berths.append(CoachBerth(number: number, type: .sideLower)); number += 1
            berths.append(CoachBerth(number: number, type: .sideUpper)); number += 1
        }
        return berths
    }

    private static func threeACLayout() -> [CoachBerth] {
        // Simplified for skeleton
        return sleeperLayout()
    }

    private static func twoACLayout() -> [CoachBerth] {
        // Simplified for skeleton
        return sleeperLayout()
    }

    private static func chairCarLayout() -> [CoachBerth] {
        // Simplified for skeleton
        return (1...72).map { CoachBerth(number: $0, type: .seat) }
    }
}
