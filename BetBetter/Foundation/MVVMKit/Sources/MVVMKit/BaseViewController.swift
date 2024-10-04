//
//  File.swift
//
//
//  Created by Bilal on 3.10.2024.
//

import UIKit
import Foundation

/// A base view controller class that binds a view model to a view.
/// - VM: A generic type conforming to `BaseViewModelable`.
/// - ViewSource: A generic type that is a subclass of `BaseView`.
open class BaseViewController<VM: BaseViewModelable, ViewSource: BaseView>: UIViewController {
    
    // MARK: - Public Properties
    
    /// The view model associated with the view controller.
    public var viewModel: VM
    
    /// The view source associated with the view controller. This is the main view of the controller.
    public var viewSource: BaseView
    
    // MARK: - Private Properties
    
    /// An activity indicator used to display loading states. It's hidden when not animating.
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Initializers
    
    /// Initializes the view controller with a given view model and view.
    /// - Parameters:
    ///   - viewModel: The view model to bind to the controller.
    ///   - view: The view to be used as the main view of the controller.
    public init(viewModel: VM, view: BaseView) {
        self.viewModel = viewModel
        self.viewSource = view
        super.init(nibName: nil, bundle: nil)
        bindVieWModelObservers()  // Bind the view model observers to handle actions.
    }

    /// Not supported initializer for Storyboards.
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not supported by Storyboard")
    }
    
    // MARK: - UIViewController Lifecycle
    
    /// Loads the view. In this case, sets the view to the provided `viewSource`.
    open override func loadView() {
        view = viewSource
    }
    
    /// Called after the view has been loaded. It triggers the view model's `viewDidLoad` method and sets up the activity indicator.
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupActivityIndicator()  // Set up the activity indicator in the view hierarchy.
    }
    
    /// Called before the view is added to the window. It triggers the view model's `viewWillAppear` method and hides the navigation bar.
    /// - Parameter animated: A boolean indicating whether the appearance is animated.
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Called before the view is removed from the window.
    /// - Parameter animated: A boolean indicating whether the disappearance is animated.
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Public Methods
    
    /// Binds the view model's base actions to the view controller's action handlers.
    /// Observes actions like loading, error handling, or keyboard management.
    open func bindVieWModelObservers() {
        viewModel.baseAction = { [weak self] action in
            self?.handleBaseAction(action)  // Handle the actions triggered by the view model.
        }
    }
    
    // MARK: - Private Methods
    
    /// Handles common actions sent from the view model such as loading, error, or closing the keyboard.
    /// - Parameter action: The action received from the view model.
    private func handleBaseAction(_ action: CommonActions) {
        switch action {
        case .loading(let isHidden):
            // Show or hide the activity indicator based on the loading state.
            isHidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
            view.bringSubviewToFront(activityIndicator)  // Ensure the activity indicator is in the front.
        case .error:
            // Future error handling can be implemented here.
            break
        case .closeKeyboard:
            // Close the keyboard when the action to close it is triggered.
            view.endEditing(true)
        }
    }
    
    /// Sets up the activity indicator and adds it to the view with layout constraints.
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        // Center the activity indicator in the view.
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
