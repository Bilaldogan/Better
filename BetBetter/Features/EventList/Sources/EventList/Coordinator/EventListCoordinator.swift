//
//  EventListCoordinator.swift
//  EventList
//
//  Created by Bilal on 4.10.2024.
//
import UIKit
import Foundation
import ToolKit
import MVVMKit
import Data

public protocol EventListCoordinatable: AnyObject, Coordinator {
    func showEventDetail(_ id: String, sportTitle: String, sportKey: String)
}

public protocol EventListCoordinatorDelegate: EventListCoordinatable {}

public final class EventListCoordinator: EventListCoordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public weak var delegate: EventListCoordinatorDelegate?
    public weak var parent: Coordinator?
    public var navigationController: UINavigationController?

    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public func start() {
        let layoutHelper = EventListLayoutHelper()
        let viewModel = ListViewModel(
            coordinator: self,
            repository: DependencyContainer.shared.resolve(RepositoryContainer.self).eventsRepository,
            envManager: DependencyContainer.shared.resolve(EnvManageable.self)
        )
        let listViewController = ListViewController(viewModel: viewModel, view: EventListView())
        listViewController.layoutHelper = layoutHelper
        layoutHelper.listener = viewModel
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    public func showEventDetail(_ id: String, sportTitle: String, sportKey: String) {
        delegate?.showEventDetail(id, sportTitle: sportTitle, sportKey: sportKey)
    }
}
