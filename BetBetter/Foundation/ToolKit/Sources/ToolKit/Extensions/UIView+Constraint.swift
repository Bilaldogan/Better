//
//  UIView+Constraint.swift
//  ToolKit
//
//  Created by Bilal on 4.10.2024.
//
import UIKit

public extension UIView {
    
    func fit(to view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    func fit(to layoutGuide: UILayoutGuide) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    func addToConstraint(to view: UIView, inset: (top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat)) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.leading),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.trailing),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom),
        ])
    }

}
