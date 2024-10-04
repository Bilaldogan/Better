//
//  BaseView.swift
//  MVVMKit
//
//  Created by Bilal on 4.10.2024.
//

import UIKit
import ToolKit

/// A custom UIView that can manage either a scrollable or non-scrollable stack view layout.
/// Provides flexibility with safe area handling and the ability to add subviews dynamically.
public class BaseView: UIView {
    
    // MARK: - Private Properties
    
    /// A UIScrollView that contains the stack view. Only added when `isScrollable` returns true.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    /// A vertical UIStackView that holds all subviews.
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializers
    
    /// Initializes the BaseView programmatically.
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    /// Initializes the BaseView from an Interface Builder or Storyboard.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public Methods
    
    /// Adds a single view to the stack view.
    /// - Parameter view: The view to add.
    public func addArrangedSubview(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }
    
    /// Adds multiple views to the stack view.
    /// - Parameter views: The views to add.
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.stackView.addArrangedSubview(view)
        }
    }
    
    /// Adds a sticky view at the bottom of the BaseView.
    /// - Parameter view: The view to make sticky at the bottom.
    public func addStickyView(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Overrideable Methods
    
    /// Determines if the content should be scrollable.
    /// - Returns: A boolean indicating if the view should scroll.
    func isScrollable() -> Bool {
        return false
    }
    
    /// Determines if the stack view should fill the entire view height.
    /// - Returns: A boolean indicating if the stack view should fill.
    func isFilled() -> Bool {
        return false
    }
    
    /// Determines if safe area constraints should be used.
    /// - Returns: A boolean indicating if safe area should be respected.
    func useSafeArea() -> Bool {
        return true
    }
    
    // MARK: - Private Methods
    
    /// Sets up the view based on its scrollable state.
    private func setupView() {
        if isScrollable() {
            setupWithScrollView()
        } else {
            setupWithoutScrollView()
        }
    }
    
    /// Sets up the view with a scrollable stack view.
    private func setupWithScrollView() {
        addSubview(scrollView)
        scrollView.fit(to: self)  // Assuming `fit(to:)` method is implemented to pin edges.
        
        scrollView.addSubview(stackView)
        stackView.fit(to: scrollView.contentLayoutGuide)
        
        let bottomInset = useSafeArea() ? -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) : 0
        
        let heightConstraint = stackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, constant: bottomInset)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
    }
    
    /// Sets up the view without a scroll view, adding the stack view directly to the BaseView.
    private func setupWithoutScrollView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        if isFilled() {
            if useSafeArea() {
                self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
            }
        } else {
            if useSafeArea() {
                self.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
            } else {
                self.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor).isActive = true
            }
        }
    }
}

extension BaseView: UIScrollViewDelegate {}
