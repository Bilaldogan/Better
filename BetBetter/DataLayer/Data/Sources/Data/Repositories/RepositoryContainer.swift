//
//  RepositoryContainer.swift
//
//
//  Created by Bilal on 7.10.2024.
//

import NetworkInterface

public class RepositoryContainer {
    private let networkProvider: NetworkProviderInterface

    public let eventsRepository: EventsRepositoryable
    public let oddsRespository: OddsRepositoryable
    
    public init(_ networkProvider: NetworkProviderInterface) {
        self.networkProvider = networkProvider
        eventsRepository = EventsRepository(networkProvider)
        oddsRespository = OddsRepository(networkProvider)
    }
}
