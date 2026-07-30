//
//  TrainRepositoryProtocol.swift
//  
//
//  Created by Dinesh on 7/30/26.
//

func getSchedule(for trainNumber: String) async throws -> Train
func getLiveStatus(for trainNumber: String, journeyDate: Date?) async throws -> LiveStatusSnapshot
func searchTrains(by query: String) async throws -> [Train]
func getTrainsBetween(from: String, to: String) async throws -> [Train]
func saveJourney(_ journey: Journey) throws
func fetchJourneys() throws -> [Journey]
