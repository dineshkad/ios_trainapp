//
//  RadarMapView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/RadarMap/RadarMapView.swift

import SwiftUI
import MapKit

struct RadarMapView: View {
    @StateObject private var viewModel: RadarMapViewModel

    init(trainRepository: TrainRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: RadarMapViewModel(trainRepository: trainRepository))
    }

    var body: some View {
        content
            .navigationTitle("RadarMap")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.loadAnnotations()
            }
    }

    private var content: some View {
        Group {
            if !viewModel.canUseRadarMap {
                VStack(spacing: 8) {
                    Text("RadarMap is a Pro feature")
                        .font(.headline)
                    Text("Upgrade to RailRadar Pro to see the all-India radar map.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ZStack(alignment: .top) {
                    Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.annotations) { annotation in
                        MapAnnotation(coordinate: annotation.coordinate) {
                            TrainAnnotationView(annotation: annotation)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Filters (coming soon)")
                            .font(.caption)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 40)
                            .padding(.leading, 16)
                        Spacer()
                    }

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(8)
                            .padding()
                    }
                }
            }
        }
    }
}
