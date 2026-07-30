// RailRadar/Features/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    private let trainRepository: TrainRepositoryProtocol
    private let onboardService: OnboardTrackingServiceProtocol

    init() {
        let apiKey = "YOUR_RAILRADAR_API_KEY" // Replace later with secure config
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
