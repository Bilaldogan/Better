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
    
    override init() {
        super.init()
        prepare()
        draw()
    }
    
    private func prepare() {
        backgroundColor = .systemGreen
        
        sportTitleLabel.textAlignment = .center
        sportTitleLabel.text = "TR ligi"
        
        dateLabel.text = "7 Ekim"
        dateLabel.textAlignment = .center
        
        timeLabel.text = "21: 00"
        timeLabel.textAlignment = .center
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
        
        sumView.setEventDetails(item)
    }
}

// MARK: - Drawing
private extension EventDetailView {
    
    /// This method should use draw the views in superview.
    /// - Example addSubview, addArrangedSubview, updatePadding...
    func draw() {
        addArrangedSubviews(
            sportTitleLabel,
            sumView,
            dateLabel,
            timeLabel,
            UIView()
        )
    }
    
}
