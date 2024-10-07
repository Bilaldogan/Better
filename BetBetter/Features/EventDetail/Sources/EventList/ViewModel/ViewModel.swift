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

enum DetailPageActions {
}

protocol EventDetailViewModelable: BaseViewModelable, ActionSendable where ActionType == DetailPageActions {
}

final class EventDetailViewModel: BaseViewModel, EventDetailViewModelable {
    typealias ActionType = DetailPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : EventDetailCoordinatable?
    
    private var envManager: EnvManageable
    private let repository: EventsRepositoryable
    
    init(
        coordinator: EventDetailCoordinatable?,
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
    
    func fetchData() {}
    
}
