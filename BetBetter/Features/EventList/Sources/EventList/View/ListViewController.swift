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
                               VS: BaseView>: BaseViewController<VM, VS> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            switch action {
            case .reload:
                print("reload")
            }
        }
    }
    
}
