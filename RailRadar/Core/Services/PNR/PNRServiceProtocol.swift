//
//  PNRServiceProtocol.swift
//  
//
//  Created by Dinesh on 7/30/26.
//
// RailRadar/Core/Services/PNR/PNRServiceProtocol.swift

import Foundation

protocol PNRServiceProtocol {
    func fetchPNR(_ pnr: String) async throws -> PNRDetails
}
