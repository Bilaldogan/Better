//
//  OddsRequestItem.swift
//  Data
//
//  Created by Bilal on 7.10.2024.
//

import Foundation
import NetworkInterface

struct OddsRequestItem: HTTPTask {
    typealias Response = OddResponseItem
    let route: Route
    
    var parameters: [String : Any]? {
        ["regions": "eu"]
    }
    
    init(sport: String, eventId: String) {
        route = .get("/sports/\(sport)/events/\(eventId)/odds")
    }
    
}

public struct OddResponseItem: Decodable {
    public let id, sportKey, sportTitle: String
    public let commenceTime: Date
    public let homeTeam, awayTeam: String
    public let bookmakers: [Bookmaker]
}

// MARK: - Bookmaker
public struct Bookmaker: Decodable {
    public let key, title: String
    public let markets: [Market]
}

// MARK: - Market
public struct Market: Decodable {
    public let key: String
    public let lastUpdate: Date
    public let outcomes: [Outcome]
}

// MARK: - Outcome
public struct Outcome: Decodable {
    public let name: String
    public let price: Double
}
