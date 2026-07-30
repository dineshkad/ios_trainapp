//
//  SettingsView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/Settings/SettingsView.swift

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationView {
            List {
                Section {
                    SubscriptionSectionView()
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 4)
                }

                Section(header: Text("Extensions")) {
                    HStack {
                        Image(systemName: "clock.badge.checkmark")
                        Text("Live Activities (coming soon)")
                    }
                    HStack {
                        Image(systemName: "rectangle.on.rectangle")
                        Text("Lock Screen Widgets (coming soon)")
                    }
                    HStack {
                        Image(systemName: "applewatch")
                        Text("Apple Watch (coming soon)")
                    }
                }

                Section(header: Text("Customize")) {
                    HStack {
                        Image(systemName: "app")
                        Text("App Icon (coming soon)")
                    }
                    HStack {
                        Image(systemName: "ruler")
                        Text("Units (coming soon)")
                    }
                }

                Section(header: Text("Manage")) {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Import Journeys (coming soon)")
                    }
                    HStack {
                        Image(systemName: "person.crop.circle")
                        Text("Account Data (coming soon)")
                    }
                }

                Section(header: Text("About")) {
                    HStack {
                        Text("App Version")
                        Spacer()
                        Text(viewModel.appVersion)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
