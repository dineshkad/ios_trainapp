//
//  SettingsViewModel.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Settings/SettingsViewModel.swift

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    // Placeholder for future settings state (theme, units, etc.)
    @Published var appVersion: String = {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }()
}
