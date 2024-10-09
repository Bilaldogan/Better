//
//  EventListView.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//
import UIKit
import ToolKit
import MVVMKit

final class EventDetailView: BaseView {
    
    private let sportTitleLabel = UILabel()
    private let sumView = EventSumView()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let oddsTitleLabel = UILabel()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    override init() {
        super.init()
        prepare()
        draw()
    }
    
    private func prepare() {
        backgroundColor = .systemGreen
        collectionView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        sportTitleLabel.textAlignment = .center
        sportTitleLabel.text = "TR ligi"
        
        dateLabel.text = "7 Ekim"
        dateLabel.textAlignment = .center
        
        timeLabel.text = "21: 00"
        timeLabel.textAlignment = .center
        
        oddsTitleLabel.font = .systemFont(ofSize: 20)
        oddsTitleLabel.textAlignment = .center
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isFilled() -> Bool {
        return true
    }
    
    public func setEventDetails(_ item: EventDetailDisplayItem) {
        sportTitleLabel.text = item.sportTitle
        dateLabel.text = item.date
        timeLabel.text = item.time
        
        oddsTitleLabel.text = item.oddsTitle
        
        sumView.setEventDetails(item)
    }
}

// MARK: - Drawing
private extension EventDetailView {
    
    /// This method should use draw the views in superview.
    /// - Example addSubview, addArrangedSubview, updatePadding...
    func draw() {
        
        let seperator = UIView()
        seperator.backgroundColor = .yellow
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addArrangedSubviews(
            sportTitleLabel,
            sumView,
            dateLabel,
            timeLabel,
            seperator,
            oddsTitleLabel,
            collectionView
        )
    }
    
}
