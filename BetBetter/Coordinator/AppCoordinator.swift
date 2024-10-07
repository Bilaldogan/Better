//
//  AppCoordinator.swift
//  BetBetter
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import UIKit
import ToolKit
import EventList
import EventDetail
import MVVMKit

class AppCoordinator: Coordinator {
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.isHidden = false
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        let coordinator = EventListCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: EventListCoordinatorDelegate {
    
    func showEventDetail(_ id: String, sportTitle: String, sportKey: String) {
        let coordinator = EventDetailCoordinator(
            navigationController: navigationController,
            transtionData: .init(id: id, sportKey: sportKey)
        )
        coordinator.delegate = self
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator: EventDetailCoordinatorDelegate { }

