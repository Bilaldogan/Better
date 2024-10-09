//
//  ObjectConverter.swift
//  EventDetail
//
//  Created by Bilal on 7.10.2024.
//
import Foundation
import Data
import ToolKit
import Basket

struct EventDetailObjectConverter {
    
    func getEventDetail(from response: OddResponseItem) -> EventDetailDisplayItem {
        let matchInfo = "\(response.homeTeam) - \(response.awayTeam)"
        return .init(
            sportTitle: response.sportTitle,
            homeTeamSymbol: response.homeTeam.getAcronym(),
            awayTeamSymbol: response.awayTeam.getAcronym(),
            matchInfo: matchInfo,
            date: getDate(from: response.commenceTime),
            time: getHour(from: response.commenceTime),
            oddsTitle: "Odd List"
        )
    }
    
    func getOdds(from response: OddResponseItem, basket: Basket) -> [OddsDisplayItem] {
        var allOdds: [OddsDisplayItem] = []
        
        response.bookmakers.forEach { bookmaker in
            bookmaker.markets.forEach { market in
                
                let basketOdd = basket.getSelectedOdd(for: BasketOdd(
                    eventId: response.id,
                    bookmaker: bookmaker.key,
                    marketKey: market.key,
                    selectedOdd: .draw //TODO: fix make optional
                ))
                
                let odds = market.outcomes.map { outcome in
                    let type: OddType
                    switch outcome.name {
                    case response.awayTeam:
                        type = .away
                    case response.homeTeam:
                        type = .home
                    default:
                        type = .draw
                    }
                    
                    return OddDisplayItem(
                        type: type,
                        price: outcome.price,
                        isSelected: basketOdd == type
                    )
                }
                
                allOdds.append(.init(
                    eventId: response.id,
                    bookmaker: bookmaker.key,
                    marketKey: market.key,
                    odds: odds
                ))
            }
        }
     
        return allOdds
    }
    
    func selectOdds(from basketOdds: Set<BasketOdd>, odds: [OddsDisplayItem]) ->  [OddsDisplayItem] {
        var selectedOdds: [OddsDisplayItem] = []
        odds.enumerated().forEach { (index,odd) in
            if let basketOdd = basketOdds.first(where: {
                $0.eventId == odd.eventId &&
                $0.bookmaker == odd.bookmaker &&
                $0.marketKey == odd.marketKey
            }) {
                var mutatedOdd = odd
                mutatedOdd.selectOdd(with: basketOdd.selectedOdd)
                selectedOdds.append(mutatedOdd)
            } else {
                var mutatedOdd = odd
                mutatedOdd.selectOdd(with: nil)
                selectedOdds.append(mutatedOdd)
            }
            
        }
        return selectedOdds
    }
    
    func converToBasketOdd(from item: OddsDisplayItem, oddIndex: Int) -> BasketOdd {
        let odd = item.odds[oddIndex]
        let basketSelectedOdd: OddType
        switch odd.type {
        case .away:
            basketSelectedOdd = .away
        case .home:
            basketSelectedOdd = .home
        case .draw:
            basketSelectedOdd = .draw
        }
        
        let basketOdd = BasketOdd(
            eventId: item.eventId,
            bookmaker: item.bookmaker,
            marketKey: item.marketKey,
            selectedOdd: basketSelectedOdd
        )
        
        return basketOdd
    }
    
    
    private func getDate(from date: Date) -> String {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: currentDate)
    }
    
    private func getHour(from date: Date) -> String {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: currentDate)
    }
}
