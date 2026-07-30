//
//  JourneyDateResolver.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Core/Models/JourneyDateResolver.swift

import Foundation

struct JourneyDateResolver {
    /// Returns the calendar date for a stop given journeyDate and stop's dayOffset.
    /// dayOffset = 1 → same as journeyDate, 2 → next day, etc.
    static func date(for stop: StopSchedule, journeyDate: Date, calendar: Calendar = .current) -> Date {
        let daysToAdd = stop.dayOffset - 1
        return calendar.date(byAdding: .day, value: daysToAdd, to: journeyDate) ?? journeyDate
    }
}
