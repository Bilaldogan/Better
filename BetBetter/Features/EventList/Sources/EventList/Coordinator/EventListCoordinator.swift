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
    func showEventDetail()
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
        let viewModel = ListViewModel(
            coordinator: self,
            repository: DependencyContainer.shared.resolve(RepositoryContainer.self).eventsRepository,
            envManager: DependencyContainer.shared.resolve(EnvManageable.self)
        )
        let listViewController = ListViewController(viewModel: viewModel, view: EventListView())
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    public func showEventDetail() {
        delegate?.showEventDetail()
    }
}
