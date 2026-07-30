
// RailRadar/Features/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    private let trainRepository: TrainRepositoryProtocol

    init() {
        let apiKey = "rg_9b04a7b5a00a4ff180bb6ad4dd6c1868" // Replace later with secure config
        let baseURL = URL(string: "https://api.railradar.in")!
        let networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey)
        let apiClient = RailRadarAPIClient(networkClient: networkClient)
        self.trainRepository = TrainRepository(apiClient: apiClient)
    }

    var body: some View {
        TabView {
            MyTrainsView(trainRepository: trainRepository)
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

struct FriendsPlaceholderView: View {
    var body: some View {
        Text("Friends")
            .font(.largeTitle)
            .padding()
    }
}

struct PassportPlaceholderView: View {
    var body: some View {
        Text("Passport")
            .font(.largeTitle)
            .padding()
    }
}
