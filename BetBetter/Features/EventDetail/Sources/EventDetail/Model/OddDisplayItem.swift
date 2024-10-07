//
//  EventCellDisplayItem.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//

enum Sections {
    case events
}

struct OddDisplayItem: Hashable {
    let id: String
    let homeTeam: String
    let awayTeam: String
    let date: String
}

enum OddResultType: String {
    case home = "H"
    case away = "A"
    case draw = "D"
}
