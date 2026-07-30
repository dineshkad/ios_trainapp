//
//  TrainAnnotationView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/RadarMap/TrainAnnotationView.swift

import SwiftUI
import MapKit

struct TrainAnnotationView: View {
    let annotation: TrainAnnotation

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "tram.fill")
                .font(.caption)
                .foregroundColor(.blue)
            Text(annotation.trainNumber)
                .font(.caption2)
                .padding(4)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(4)
        }
    }
}
