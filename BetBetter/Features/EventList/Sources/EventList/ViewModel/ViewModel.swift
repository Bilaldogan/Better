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
    
    private var events = [EventCellDisplayItem]()
    
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
                self.events = try await repository.getEvents(sport: "soccer_turkey_super_league").map({
                    EventCellDisplayItem(
                        id: $0.id,
                        homeTeam: $0.homeTeam,
                        awayTeam: $0.awayTeam,
                        sportKey: $0.sportKey,
                        sportTitle: $0.sportTitle,
                        date: "date"
                    )
                })
                sendAction(.reload(events))
            } catch {
                print("error", error)
            }
            
        }
    }
    
}

//MARK: - EventListListener
extension ListViewModel: EventListListener {
    func didSelectItem(_ indexPath: IndexPath) async {
        let event = events[indexPath.row]
        await MainActor.run {
            coordinator?.showEventDetail(event.id, sportTitle: event.sportTitle, sportKey: event.sportKey)
        }
    }
}
