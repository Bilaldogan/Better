//
//  PopularMoviesRequestItem.swift
//
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import NetworkInterface

struct EventsRequestItem: HTTPTask {
    typealias Response = [EventResponseItem]
    let route: Route
 
    init(sport: String) {
        route = .get("/sports/\(sport)/events")
    }
}

public struct EventResponseItem: Decodable {
    public let id, sportKey, sportTitle: String
    public let commenceTime: Date
    public let homeTeam, awayTeam: String

}
