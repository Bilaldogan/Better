//
//  ViewModel.swift
//  EventList
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import ToolKit
import MVVMKit

enum ListPageActions {
    case reload
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
    
    init(
        coordinator: EventListCoordinatable?,
        envManager: EnvManageable
    ) {
        self.coordinator = coordinator
        self.envManager = envManager
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendAction(.reload)
        fetchData()
    }
    
    func didChangeSearchText(_ key: String) {
        sendAction(.reload)
    }
    
    func didSearchClear() {
    }
    
    func didTapSearchDone() {
        sendAction(.closeKeyboard)
    }
    
    func fetchData() {
    }
    
    

}

