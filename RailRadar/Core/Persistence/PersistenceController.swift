//
//  PersistenceController.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
final class PersistenceController {
    static let shared = PersistenceController()
    let container: ModelContainer

    func save(_ context: ModelContext) throws { ... }
    // Helper fetch methods, e.g., fetchJourneys(), fetchTrain(byNumber:), etc.
}
