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
import Basket
import Combine

enum DetailPageActions {
    case reloadOdds([OddsDisplayItem])
    case setEventDetails(EventDetailDisplayItem)
}

protocol EventDetailViewModelable: BaseViewModelable, ActionSendable where ActionType == DetailPageActions {
}

final class EventDetailViewModel: BaseViewModel, EventDetailViewModelable {
    typealias ActionType = DetailPageActions
    var observer: ((ActionType) -> Void)?
    weak var coordinator : EventDetailCoordinatable?
    
    private var cancellables = Set<AnyCancellable>()

    private var envManager: EnvManageable
    private let repository: OddsRepositoryable
    private let transitionData: EventDetailTransitionData
    private let objectConverter: EventDetailObjectConverter
    private let basket: Basket
    private var odds: [OddsDisplayItem] = []

    init(
        coordinator: EventDetailCoordinatable?,
        repository: OddsRepositoryable,
        transitionData: EventDetailTransitionData,
        envManager: EnvManageable,
        objectConverter: EventDetailObjectConverter,
        basket: Basket
    ) {
        self.coordinator = coordinator
        self.envManager = envManager
        self.repository = repository
        self.transitionData = transitionData
        self.objectConverter = objectConverter
        self.basket = basket
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeBasket()
        fetchData()
    }
    
    func fetchData() {
        Task {
            sendAction(.loading(isHidden: false))
            do {
                let response = try await repository.getOdds(transitionData.id, sportKey: transitionData.sportKey)
                
                sendAction(.loading(isHidden: true))
                sendAction(.setEventDetails(objectConverter.getEventDetail(from: response)))
                odds = objectConverter.getOdds(
                    from: response,
                    basket: basket
                )
                sendAction(.reloadOdds(odds))
            } catch {
                sendAction(.loading(isHidden: true))
            }
        }
    }
    
    private func observeBasket() {
        basket.oddsSubject.sink { [weak self] basketodds in
            guard let self else { return }
            self.odds = objectConverter.selectOdds(from: basketodds, odds: self.odds)
            sendAction(.reloadOdds(odds))
        }
        .store(in: &cancellables)
    }
    
}

extension EventDetailViewModel: EventOddsListener {
    func didSelectOddItem(at indexPath: IndexPath, oddIndex: Int) {
        let selectedItem = odds[indexPath.row]
        let basketOdd = objectConverter.converToBasketOdd(from: selectedItem, oddIndex: oddIndex)
        basket.toggleOdd(basketOdd)
    }

}
