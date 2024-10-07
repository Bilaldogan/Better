//
//  EventDetailCoordinator.swift
//  EventDetail
//
//  Created by Bilal on 4.10.2024.
//
import UIKit
import Foundation
import ToolKit
import MVVMKit
import Data

public protocol EventDetailCoordinatable: AnyObject, Coordinator {
}

public protocol EventDetailCoordinatorDelegate: EventDetailCoordinatable {}

public final class EventDetailCoordinator: EventDetailCoordinatable {
    // MARK: - Variables
    public var childCoordinators: [Coordinator] = []
    public weak var delegate: EventDetailCoordinatorDelegate?
    public weak var parent: Coordinator?
    public var navigationController: UINavigationController?
    private let transtionData: EventDetailTransitionData
    
    public init(
        navigationController: UINavigationController?,
        transtionData: EventDetailTransitionData
    ) {
        self.navigationController = navigationController
        self.transtionData = transtionData
    }

    public func start() {
        let viewModel = EventDetailViewModel(
            coordinator: self,
            repository: DependencyContainer.shared.resolve(RepositoryContainer.self).oddsRespository,
            transitionData: transtionData,
            envManager: DependencyContainer.shared.resolve(EnvManageable.self),
            objectConverter: EventDetailObjectConverter()
        )
        let listViewController = EventDetailViewController(viewModel: viewModel, view: EventDetailView())
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
}
