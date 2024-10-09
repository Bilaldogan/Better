//
//  OddCollectionViewCell.swift
//  EventDetail
//
//  Created by Bilal on 7.10.2024.
//

import UIKit
import ToolKit

final class OddCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var oddsStackView: UIStackView!
    
    var didTap: ((Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        oddsStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func configure(with item: OddsDisplayItem) {
        titleLabel.text = "\(item.bookmaker) - \(item.marketKey)"
        item.odds.enumerated().forEach { (index, item) in
            let oddView: OddSelectionView = OddSelectionView()
            oddView.configure(with: item)
            oddView.didTap = { [unowned self] in
                self.didTap?(index)
            }
            oddsStackView.addArrangedSubview(oddView)
        }
    }
}

final class OddSelectionView: XibView {
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oddLabel: UILabel!
    
    var didTap: (() -> Void)?
    
    override func viewDidLoad() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.red.cgColor
        addTapGesture()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        didTap?()
    }
    
    func configure(with item: OddDisplayItem) {
        priceLabel.text = "\(item.price)"
        oddLabel.text = "\(item.type.rawValue)"
        
        contentView.layer.borderWidth = item.isSelected ? 1 : 0
    }
    
}

open class XibView: UIView {
    @IBOutlet var contentView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func viewDidLoad() {}
    
    private func commonInit() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle.module
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewDidLoad()
    }
}
