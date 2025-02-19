//
//  DependencyManager.swift
//  BetBetter
//
//  Created by Bilal on 3.10.2024.
//

import Foundation
import Network
import NetworkInterface
import ToolKit
import LoggerKit
import Data

/// A utility class that manages the registration of dependencies within a dependency container.
/// This class is designed to separate the implementation details of dependency injection
/// from the rest of the application, ensuring a clean and modular structure.
final class DependencyManager {
    private(set) var container: DependencyContainerProtocol

    init(container: DependencyContainerProtocol = DependencyContainer.shared) {
        self.container = container
    }

    func registerDependencies() {
        registerEnv()
        registerLogger()
        registerNetworkService()
        registerRepositoryContainer()
    }

    private func registerEnv() {
        container.register(EnvManageable.self, instance: EnvManager(current: .dev))
    }
    
    private func registerLogger() {
        container.register(ErrorLoggable.self, instance: Logger())
    }
    
    private func registerNetworkService() {
        container.register(NetworkProviderInterface.self, instance: NetworkProvider())
    }
    
    private func registerRepositoryContainer() {
        let networkService = container.resolve(NetworkProviderInterface.self)
        let instance = RepositoryContainer(networkService)
        container.register(RepositoryContainer.self, instance: instance)
    }
}
