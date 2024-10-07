//
//  ObjectConverter.swift
//  EventDetail
//
//  Created by Bilal on 7.10.2024.
//
import Foundation
import Data
import ToolKit

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
            oddsTitle: "Odds"
        )
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
