//
//  BasketOdd.swift
//  Basket
//
//  Created by Bilal on 7.10.2024.
//

public enum OddType: String, Codable {
    case home = "H"
    case away = "A"
    case draw = "D"
}

public struct BasketOdd: Codable, Hashable {
    public let eventId: String
    public let bookmaker: String
    public let marketKey: String
    public let selectedOdd: OddType
    
    public init(eventId: String, bookmaker: String, marketKey: String, selectedOdd: OddType) {
        self.eventId = eventId
        self.bookmaker = bookmaker
        self.marketKey = marketKey
        self.selectedOdd = selectedOdd
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(eventId)
        hasher.combine(bookmaker)
        hasher.combine(marketKey)
    }
}
