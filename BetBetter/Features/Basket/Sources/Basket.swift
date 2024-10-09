//
//  Basket.swift
//  Basket
//
//  Created by Bilal on 7.10.2024.
//

import Combine

final public class Basket {
    
    public static let shared = Basket()
    
    private(set) var odds: Set<BasketOdd> = []
    
    public var oddsSubject = PassthroughSubject<Set<BasketOdd>, Never>()
    
    private init() {}

    public func getSelectedOdd(for odd: BasketOdd) -> OddType? {
        odds.first(where: { $0.hashValue == odd.hashValue })?.selectedOdd
    }
    
    public func toggleOdd(_ odd: BasketOdd) {
        if let existingOdd = odds.first(where: { $0.hashValue == odd.hashValue }) {
            odds.remove(existingOdd)
            if existingOdd.selectedOdd != odd.selectedOdd {
                odds.insert(odd)
            }
        } else {
            odds.insert(odd)
        }
        oddsSubject.send(odds)
    }
}
