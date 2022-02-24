//
//  UIView.swift
//  PT
//
//  Created by iOS Developer on 2/23/22.
//

import UIKit

extension UIView: Nameable {}

extension UIView {
    func show() {
        isHidden = false
    }

    func hide() {
        isHidden = true
    }
    
    // MARK: - Border
    func addBorder(radius: CGFloat, width: CGFloat, color: UIColor) {
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
}
