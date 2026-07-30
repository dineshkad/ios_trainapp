//
//  CoachLayoutServiceProtocol.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Services/Coach/CoachLayoutServiceProtocol.swift

import Foundation

protocol CoachLayoutServiceProtocol {
    func layout(for coachType: String) -> CoachLayout
}
