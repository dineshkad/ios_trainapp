//
//  MainTabView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

import SwiftUI

struct MainTabView: View {
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

            SearchPlaceholderView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct MyTrainsPlaceholderView: View {
    var body: some View {
        Text("My Trains")
            .font(.largeTitle)
            .padding()
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

struct SearchPlaceholderView: View {
    var body: some View {
        Text("Search")
            .font(.largeTitle)
            .padding()
    }
}
