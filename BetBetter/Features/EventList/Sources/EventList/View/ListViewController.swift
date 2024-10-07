//
//  ListViewController.swift
//  EventList
//
//  Created by Bilal on 4.10.2024.
//
import UIKit
import ToolKit
import MVVMKit

final class ListViewController<VM: ListViewModelable,
                               VS: EventListView>: BaseViewController<VM, VS> {
    
    var dataSource: UICollectionViewDiffableDataSource<Sections, EventCellDisplayItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
        viewSource.collectionView.register(cellType: EventCollectionViewCell.self, bundle: .module)
        
        dataSource = UICollectionViewDiffableDataSource<Sections, EventCellDisplayItem>(
            collectionView: viewSource.collectionView,
            cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
                guard let self else {
                    return nil
                }
                
                let cell: EventCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(with: item)
                
                return cell
            }
        )
        
        viewSource.collectionView.collectionViewLayout =  UICollectionViewCompositionalLayout { [weak self] (section, environment) -> NSCollectionLayoutSection? in
            let heightDimension : NSCollectionLayoutDimension = .absolute(60)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: heightDimension)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(16)
            return NSCollectionLayoutSection(group: group)
        }
    }
    
    
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            switch action {
            case .reload(let items):
                var snapshot = NSDiffableDataSourceSnapshot<Sections, EventCellDisplayItem>()
                snapshot.appendSections([.events])
                snapshot.appendItems(items)
                dataSource.apply(snapshot)
            }
        }
    }
    
}
