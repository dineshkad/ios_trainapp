// RailRadar/Features/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    private let trainRepository: TrainRepositoryProtocol
    private let onboardService: OnboardTrackingServiceProtocol

    init() {
        let apiKey = "rg_9b04a7b5a00a4ff180bb6ad4dd6c1868" // Replace later with secure config
        let baseURL = URL(string: "https://api.railradar.in")!
        let networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey)
        let apiClient = RailRadarAPIClient(networkClient: networkClient)
        self.trainRepository = TrainRepository(apiClient: apiClient)
        self.onboardService = OnboardTrackingService()
    }

    var body: some View {
        TabView {
            MyTrainsView(
                trainRepository: trainRepository,
                onboardService: onboardService
            )
            .tabItem {
                Label("My Trains", systemImage: "tram")
            }

            FriendsPlaceholderView()
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }

            PassportView(trainRepository: trainRepository)
                .tabItem {
                    Label("Passport", systemImage: "globe")
                }

            AddTrainView(trainRepository: trainRepository)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
