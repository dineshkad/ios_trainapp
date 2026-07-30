//
//  StopRowView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

// RailRadar/Features/TrainDetail/StopRowView.swift

import SwiftUI

struct StopRowView: View {
    let stop: StopSchedule
    let date: Date

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(stop.stationName)
                    .font(.headline)
                Text(stop.stationCode)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack {
                    if let arr = stop.arrival {
                        Text("Arr: \(arr)")
                            .font(.caption)
                    }
                    if let dep = stop.departure {
                        Text("Dep: \(dep)")
                            .font(.caption)
                    }
                }

                Text(date, style: .date)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
