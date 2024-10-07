//
//  EventListView.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//
import UIKit
import ToolKit
import MVVMKit

final class EventListView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    override init() {
        super.init()
        draw()
        collectionView.backgroundColor =  .green
    }
    
    private func prepare() {
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isFilled() -> Bool {
        return true
    }
}

// MARK: - Drawing
private extension EventListView {
    
    /// This method should use draw the views in superview.
    /// - Example addSubview, addArrangedSubview, updatePadding...
    func draw() {
        addArrangedSubview(collectionView)
    }
    
}
