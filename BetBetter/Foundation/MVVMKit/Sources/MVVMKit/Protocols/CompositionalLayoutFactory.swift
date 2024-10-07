//
//  CompositionalLayoutFactory.swift
//  MVVMKit
//
//  Created by Bilal on 7.10.2024.
//

import Foundation
import UIKit

/// A protocol that defines a contract for generating compositional layouts.
/// This protocol abstracts the layout logic from views, allowing for separation of concerns
/// between the view and its layout handling. It also enables injecting different layouts
/// or additional layout manipulations into views as needed.
///
/// - Provides a method to create and return a UICollectionViewCompositionalLayout.
public protocol CompositionalLayoutFactory {
    associatedtype SectionType: Hashable
    associatedtype ItemType: Hashable
    
    var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>? { get set }
    
    func layout() -> UICollectionViewCompositionalLayout
    func bind(for collectionView: UICollectionView)
    func applySnaphot(for items: [ItemType])
}
