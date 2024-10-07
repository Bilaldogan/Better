//
//  OddsRepository.swift
//  Data
//
//  Created by Bilal on 7.10.2024.
//

import Foundation
import NetworkInterface

public protocol OddsRepositoryable {
    func getOdds(_ id: String, sportKey: String) async throws -> OddResponseItem
}

public class OddsRepository: OddsRepositoryable {
    private let networkProvider: NetworkProviderInterface

    public init(_ networkProvider: NetworkProviderInterface) {
        self.networkProvider = networkProvider
    }
    
    public func getOdds(_ id: String, sportKey: String) async throws -> OddResponseItem {
        return try await networkProvider.request(OddsRequestItem(sport: sportKey, eventId: id))
    }

}
