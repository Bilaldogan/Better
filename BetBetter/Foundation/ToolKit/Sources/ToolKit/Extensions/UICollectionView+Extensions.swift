//
//  UITableView+Extension.swift
//
//
//  Created by Bilal on 13.09.2024.
//

import Foundation
import UIKit

public extension UICollectionView {
    /// Registers a UICollectionViewCell using its class name.
    /// The cell is registered by its class name, assuming that a NIB file exists with the same name.
    /// - Parameters:
    ///   - cellType: The UICollectionViewCell type to register.
    ///   - bundle: The bundle in which the NIB is located, default is `nil`.
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: className)
    }
    
    /// Dequeues a reusable UICollectionViewCell for the given indexPath.
    /// This method dequeues the cell using its class name as the reuse identifier.
    /// - Parameter indexPath: The index path at which the cell will be used.
    /// - Returns: A reusable UICollectionViewCell of the specified type.
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(className)")
        }
        return cell
    }
}
