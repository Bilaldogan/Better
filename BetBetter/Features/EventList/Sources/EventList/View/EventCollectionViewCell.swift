//
//  EventCollectionViewCell.swift
//  EventList
//
//  Created by Bilal on 7.10.2024.
//
import UIKit

final class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var homeTeam: UILabel!
    @IBOutlet private weak var awayTeam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with item: EventCellDisplayItem) {
        homeTeam.text = item.homeTeam
        awayTeam.text = item.awayTeam
        
    }
}
