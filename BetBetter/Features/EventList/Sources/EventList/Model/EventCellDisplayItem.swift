//
//  EventCellDisplayItem.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//

enum Sections {
    case events
}

struct EventCellDisplayItem: Hashable {
    let id: String
    let homeTeam: String
    let awayTeam: String
    let sportKey: String
    let sportTitle: String
    let date: String
}
