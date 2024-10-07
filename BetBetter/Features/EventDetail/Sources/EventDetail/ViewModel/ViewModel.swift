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
    case setEventDetails(EventDetailDisplayItem)
}

protocol EventDetailViewModelable: BaseViewModelable, ActionSendable where ActionType == DetailPageActions {
}

final class EventDetailViewModel: BaseViewModel, EventDetailViewModelable {
    typealias ActionType = DetailPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : EventDetailCoordinatable?
    
    private var envManager: EnvManageable
    private let repository: OddsRepositoryable
    private let transitionData: EventDetailTransitionData
    private let objectConverter: EventDetailObjectConverter
    
    init(
        coordinator: EventDetailCoordinatable?,
        repository: OddsRepositoryable,
        transitionData: EventDetailTransitionData,
        envManager: EnvManageable,
        objectConverter: EventDetailObjectConverter
    ) {
        self.coordinator = coordinator
        self.envManager = envManager
        self.repository = repository
        self.transitionData = transitionData
        self.objectConverter = objectConverter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        Task {
            sendAction(.loading(isHidden: false))
            do {
                let odds = try await repository.getOdds(transitionData.id, sportKey: transitionData.sportKey)
                sendAction(.loading(isHidden: true))
                sendAction(.setEventDetails(objectConverter.getEventDetail(from: odds)))
            } catch {
                print("odss error", error)
                sendAction(.loading(isHidden: true))
            }
        }
    }
    
}
