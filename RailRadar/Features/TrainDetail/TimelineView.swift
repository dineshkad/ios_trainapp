//
//  TimelineView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/TrainDetail/TimelineView.swift

import SwiftUI

struct TimelineView: View {
    let train: Train
    let journeyDate: Date

    private var stopsByDay: [(dayOffset: Int, stops: [StopSchedule])] {
        let grouped = Dictionary(grouping: train.schedule, by: { $0.dayOffset })
        return grouped
            .map { (dayOffset: $0.key, stops: $0.value.sorted(by: { $0.distance < $1.distance })) }
            .sorted(by: { $0.dayOffset < $1.dayOffset })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(stopsByDay, id: \.dayOffset) { group in
                let date = JourneyDateResolver.date(
                    for: group.stops.first ?? StopSchedule(
                        stationCode: "",
                        stationName: "",
                        arrival: nil,
                        departure: nil,
                        dayOffset: group.dayOffset,
                        distance: 0,
                        platform: nil
                    ),
                    journeyDate: journeyDate
                )

                Text("Day \(group.dayOffset) • \(date.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 8)

                ForEach(group.stops, id: \.stationCode) { stop in
                    let stopDate = JourneyDateResolver.date(for: stop, journeyDate: journeyDate)
                    StopRowView(stop: stop, date: stopDate)
                }
            }
        }
    }
}
