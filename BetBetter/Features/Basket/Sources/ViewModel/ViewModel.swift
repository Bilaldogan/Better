//
//  ViewModel.swift
//  Basket
//
//  Created by Bilal on 9.10.2024.
//

import MVVMKit
import Combine

public struct BasketDisplayItem {
    let count: String
    let price: String
}

public enum BasketActions {
    case reload(BasketDisplayItem)
}

public protocol BasketViewModelable: BaseViewModelable, ActionSendable where ActionType == BasketActions {
}

public final class BasketViewModel: BaseViewModel, BasketViewModelable {
    public typealias ActionType = BasketActions
    public var observer: ((ActionType) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    private let basket: Basket
    
    public init(basket: Basket) {
        self.basket = basket
        super.init()
        observeBasket()
    }
    
    private func observeBasket() {
        basket.oddsSubject.sink { [weak self] basketodds in
            guard let self = self else { return }
            var count = "\(basketodds.count)"
            var price: Double = 1
            basketodds.forEach { odd in
                price = price * odd.price
            }
            self.sendAction(.reload(.init(count: count, price: "\(price)")))
        }
        .store(in: &cancellables)
    }
    
}
