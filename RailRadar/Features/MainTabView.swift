// RailRadar/Features/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    // For Phase 3, we can create dependencies here or via a simple DI container.
    private let trainRepository: TrainRepositoryProtocol

    init() {
        // Create networking stack
        let apiKey = "rg_9b04a7b5a00a4ff180bb6ad4dd6c1868" // Replace later with secure config
        let baseURL = URL(string: "https://api.railradar.in")!
        let networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey)
        let apiClient = RailRadarAPIClient(networkClient: networkClient)
        self.trainRepository = TrainRepository(apiClient: apiClient)
    }

    var body: some View {
        TabView {
            MyTrainsPlaceholderView()
                .tabItem {
                    Label("My Trains", systemImage: "tram")
                }

            FriendsPlaceholderView()
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }

            PassportPlaceholderView()
                .tabItem {
                    Label("Passport", systemImage: "globe")
                }

            AddTrainView(trainRepository: trainRepository)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

// Placeholder views (unchanged or as you already have them)
