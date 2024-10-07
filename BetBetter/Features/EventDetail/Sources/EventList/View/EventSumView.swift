//
//  EventSumView.swift
//  EventDetail
//
//  Created by Bilal on 7.10.2024.
//
import UIKit

final class EventSumView: UIView {
    private let homeSymbolLabel = UILabel()
    private let awaySymbolLabel = UILabel()
    private let matchInfoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
        draw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepare() {
        homeSymbolLabel.text = "HT"
        homeSymbolLabel.textColor = .white
        homeSymbolLabel.backgroundColor = .red
        homeSymbolLabel.layer.cornerRadius = 30
        homeSymbolLabel.clipsToBounds = true
        homeSymbolLabel.textAlignment = .center
        
        awaySymbolLabel.text = "AT"
        awaySymbolLabel.textColor = .white
        awaySymbolLabel.textAlignment = .center
        awaySymbolLabel.layer.cornerRadius = 30
        awaySymbolLabel.backgroundColor = .red
        awaySymbolLabel.clipsToBounds = true

        matchInfoLabel.text = "A-B"
        matchInfoLabel.textAlignment = .center
        
        homeSymbolLabel.font = .systemFont(ofSize: 45)
        awaySymbolLabel.font = .systemFont(ofSize: 45)
        matchInfoLabel.font = .systemFont(ofSize: 20)
    }
}
    
private extension EventSumView {
    
    func draw() {
        drawHomeSymbol()
        drawAwaySymol()
        drawMatchInfoLabel()
    }
    
    func drawHomeSymbol() {
        addSubview(homeSymbolLabel)
        homeSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        homeSymbolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        homeSymbolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        homeSymbolLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        homeSymbolLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        homeSymbolLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func drawAwaySymol() {
        addSubview(awaySymbolLabel)
        awaySymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        awaySymbolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        awaySymbolLabel.centerYAnchor.constraint(equalTo: homeSymbolLabel.centerYAnchor).isActive = true
        awaySymbolLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        awaySymbolLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func drawMatchInfoLabel() {
        addSubview(matchInfoLabel)
        matchInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        matchInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        matchInfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
