//
//  EventListLayoutHelper.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//
import Foundation
import UIKit
import MVVMKit

protocol EventOddsLayoutFactory: CompositionalLayoutFactory where SectionType == Sections, ItemType == OddsDisplayItem {
    
}

protocol EventOddsListener: AnyObject {
    func didSelectOddItem(at indexPath: IndexPath, oddIndex: Int) async
}

/// Helper class responsible for setting up the compositional layout and managing the data source for the collection view.
/// Implements the `CompositionalLayoutFactory` protocol to provide the layout logic for a collection view displaying stock data.
final class EventOddsLayoutHelper: NSObject, EventOddsLayoutFactory {
    
    /// Data source for the collection view, managing the mapping of sections and items to the UI.
    var dataSource: UICollectionViewDiffableDataSource<Sections, OddsDisplayItem>?
    weak var listener: EventOddsListener?
    
    /// Creates and returns a compositional layout for the collection view.
    /// The layout uses the default section layout with an estimated height of 80 points.
    func layout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (section, environment) -> NSCollectionLayoutSection? in
            return self?.defaultSectionLayout(.absolute(100))
        }
    }
    
    /// Creates and returns a compositional layout for the collection view.
    /// The layout uses the default section layout with an estimated height of 80 points.
    /// Section-based layout customizations can be made here to differentiate layouts for different sections.
    private func defaultSectionLayout(_ heightDimension: NSCollectionLayoutDimension = .estimated(76)) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16)
        return NSCollectionLayoutSection(group: group)
    }
    
    /// Configures the data source for the collection view, providing a way to map data to cells.
    /// - Parameter collectionView: The collection view to which the data source will be bound.
    func bind(for collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layout()
        collectionView.register(cellType: OddCollectionViewCell.self, bundle: .module)
        
        dataSource = UICollectionViewDiffableDataSource<Sections, OddsDisplayItem>(
            collectionView: collectionView,
            cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell: OddCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(with: item)
                cell.didTap = { [unowned self] index in
                    Task {
                        await self?.listener?.didSelectOddItem(at: indexPath, oddIndex: index)
                    }
                }
                return cell
            }
        )
    }
    
    func applySnaphot(for items: [OddsDisplayItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, OddsDisplayItem>()
        snapshot.appendSections([.odds])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}
