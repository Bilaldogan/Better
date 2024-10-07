//
//  MovieRepository.swift
//  
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import NetworkInterface

public protocol EventsRepositoryable {
    func getEvents(sport: String) async throws -> [EventResponseItem]
}


public class EventsRepository: EventsRepositoryable {
    private let networkProvider: NetworkProviderInterface

    public init(_ networkProvider: NetworkProviderInterface) {
        self.networkProvider = networkProvider
    }
    
    public func getEvents(sport: String) async throws -> [EventResponseItem] {
        return try await  networkProvider.request(EventsRequestItem(sport: sport))
    }
}

