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
    
    var layoutHelper: (any EventListLayoutFactory)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        layoutHelper.bind(for: viewSource.collectionView)
    }
    
    
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            switch action {
            case .reload(let items):
                layoutHelper.applySnaphot(for: items)
            }
        }
    }
    
}
