//
//  CoachLayoutView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// Example in MainTabView for testing only:
CoachLayoutView(
    pnrService: StubPNRService(),
    coachLayoutService: CoachLayoutService()
)
.tabItem {
    Label("Coach", systemImage: "bed.double")
}
