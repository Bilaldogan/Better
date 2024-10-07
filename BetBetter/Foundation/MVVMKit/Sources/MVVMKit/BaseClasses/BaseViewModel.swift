//
//  BaseViewModel.swift
//
//
//  Created by Bilal on 3.10.2024.
//

import Foundation
import LoggerKit
import ToolKit

public protocol BaseViewModelable: LifeCycleObservable, AnyObject {
    var baseAction: ((CommonActions) -> Void)? { get set }
}

open class BaseViewModel: BaseViewModelable {
    /// It contains shared actions
    public var baseAction: ((CommonActions) -> Void)?
    
    /// Can add default operation
    open func viewDidLoad() {}
    
    /// Can add default operation
    open func viewWillAppear() {}
    
    public var logger: ErrorLoggable?
    
    public init(logger: ErrorLoggable? = DependencyContainer.shared.resolve(ErrorLoggable.self)) {
        self.logger = logger
    }
    
    public func sendAction(_ action: CommonActions) {
        if Thread.isMainThread {
            baseAction?(action)
        } else {
            DispatchQueue.main.async {
                self.baseAction?(action)
            }
        }
    }
    
    /// For reduce repeated use
    open func execute<T>(_ function: @autoclosure @escaping () async throws -> T) async throws -> T {
        do {
            let result = try await function()
            return result
        } catch {
            await handleError(error)
            throw error
        }
    }

    /// Error handling method that can be overridden from child
    open func handleError(_ error: Error) async {
        sendAction(.loading(isHidden: true))
        logger?.log(error, with: [:])
    }
}
