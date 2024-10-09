//
//  EventCellDisplayItem.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//
import Basket

enum Sections {
    case odds
}

struct OddsDisplayItem: Hashable {
    let eventId: String
    let bookmaker: String
    let marketKey: String
    var odds: [OddDisplayItem]
    
    mutating func selectOdd(with type: OddType?) {
        odds = odds.map { odd in
            var mutableOdd = odd
            mutableOdd.isSelected = (odd.type == type)
            return mutableOdd
        }
    }
}

struct OddDisplayItem: Hashable {
    let type: OddType
    let price: Double
    var isSelected: Bool
}

