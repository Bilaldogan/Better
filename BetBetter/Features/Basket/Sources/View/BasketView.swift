//
//  BasketView.swift
//  Basket
//
//  Created by Bilal on 9.10.2024.
//

import UIKit

final public class BasketView: UIView {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let oddsCountLabel = UILabel()
    private let oddsValueLabel = UILabel()
    private var viewModel: any BasketViewModelable
    
    public init(viewModel: any BasketViewModelable) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        bindVieWModelObservers()
        prepare()
        draw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bindVieWModelObservers() {
        viewModel.observer = { [weak self] action in
            guard let self = self else {return}
            switch action {
            case .reload(let item):
                oddsCountLabel.text = item.count
                oddsValueLabel.text = item.price
            }
        }
    }
    
    private func prepare() {
        backgroundColor = .darkGray
        layer.cornerRadius = 8
        titleLabel.text = "Basket"
        titleLabel.font = .systemFont(ofSize: 20)
        
        oddsCountLabel.text = "0"
        
        oddsValueLabel.text = "0 TRY"
    }
    
}
    
private extension BasketView {
    
    func draw() {
        drawStackView()
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(oddsCountLabel)
        
        stackView.addArrangedSubview(oddsValueLabel)
    }
    
    func drawStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
    }
}
