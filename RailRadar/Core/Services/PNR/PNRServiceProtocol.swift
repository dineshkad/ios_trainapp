//
//  PNRServiceProtocol.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
protocol PNRServiceProtocol {
    func fetchPNR(_ pnr: String) async throws -> PNRDetails
}
