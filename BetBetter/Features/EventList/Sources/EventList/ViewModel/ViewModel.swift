//
//  ViewModel.swift
//  EventList
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import ToolKit
import MVVMKit
import Data

enum ListPageActions {
    case reload([EventCellDisplayItem])
}

protocol ListViewModelable: BaseViewModelable, ActionSendable where ActionType == ListPageActions {
    func didChangeSearchText(_ key: String)
    func didSearchClear()
    func didTapSearchDone()
}

final class ListViewModel: BaseViewModel, ListViewModelable {
    typealias ActionType = ListPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : EventListCoordinatable?
    
    private var envManager: EnvManageable
    private let repository: EventsRepositoryable
    
    init(
        coordinator: EventListCoordinatable?,
        repository: EventsRepositoryable,
        envManager: EnvManageable
    ) {
        self.coordinator = coordinator
        self.envManager = envManager
        self.repository = repository
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func didChangeSearchText(_ key: String) {
    }
    
    func didSearchClear() {
        
    }
    
    func didTapSearchDone() {
        sendAction(.closeKeyboard)
    }
    
    func fetchData() {
        Task {
            do {
                let events = try await repository.getEvents(sport: "americanfootball_nfl")
                sendAction(.reload(events.map({
                    return EventCellDisplayItem(id: $0.id, homeTeam: $0.homeTeam, awayTeam: $0.awayTeam, date: "date")
                })))
            } catch {
                print("error", error)
            }
            
        }
    }
    
}

//MARK: - EventListListener
extension ListViewModel: EventListListener {
    func didSelectItem(_ indexPath: IndexPath) async {
        print("İtem selected at", indexPath)
    }
}
