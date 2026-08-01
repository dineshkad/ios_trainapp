//
//  FriendsPlaceholderView.swift
//  RailRadar
//
//  Created by Dinesh on 8/1/26.
//

//
//  FriendsPlaceholderView.swift
//

import SwiftUI

struct FriendsPlaceholderView: View {
    var body: some View {
        ContentUnavailableView(
            "Friends",
            systemImage: "person.2",
            description: Text("Share journeys and see friends' trips — coming soon.")
        )
        .navigationTitle("Friends")
    }
}
