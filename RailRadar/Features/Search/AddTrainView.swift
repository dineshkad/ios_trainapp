//
//  AddTrainView.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Features/Search/AddTrainView.swift

import SwiftUI

struct AddTrainView: View {
    @StateObject private var viewModel: AddTrainViewModel
    @State private var isShowingDatePicker = false
    @Environment(\.dismiss) private var dismiss

    init(trainRepository: TrainRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: AddTrainViewModel(trainRepository: trainRepository))
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Add Train")
                            .font(.largeTitle)
                            .bold()
                        Text("Search train number or name, then select date")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)

                // Search field
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search train number or name…", text: $viewModel.query)
                        .textInputAutocapitalization(.characters)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)

                // Results
                if !viewModel.results.isEmpty {
                    List(viewModel.results) { result in
                        Button {
                            viewModel.selectResult(result)
                        } label: {
                            SearchResultRow(result: result)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text("Search for a train to see results")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }

                // Selected + date
                if let selected = viewModel.selectedResult {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Selected Train")
                            .font(.headline)
                        Text("\(selected.trainNumber) • \(selected.trainName)")
                            .font(.subheadline)

                        HStack {
                            Text("Journey Date:")
                            Spacer()
                            Button {
                                isShowingDatePicker = true
                            } label: {
                                Text(viewModel.journeyDate, style: .date)
                                    .bold()
                            }
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                // Save button
                if viewModel.selectedResult != nil {
                    Button {
                        Task {
                            await viewModel.saveJourney()
                            if viewModel.saveErrorMessage == nil {
                                dismiss()
                            }
                        }
                    } label: {
                        if viewModel.isSaving {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("Save Journey")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }

                if let error = viewModel.saveErrorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowingDatePicker) {
                DatePickerSheet(date: $viewModel.journeyDate)
            }
        }
    }
}
