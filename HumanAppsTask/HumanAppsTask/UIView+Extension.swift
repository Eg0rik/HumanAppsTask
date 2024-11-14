//
//  UIView+Extension.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

extension UIView {
    ///Adds subviews and sets the views property `translatesAutoresizingMaskIntoConstraints` to `false`.
    func addSubviews(_ views: UIView...) {
        for i in views {
            self.addSubview(i)
        }
    }
    
    func setBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat = 0) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = cornerRadius
        
        clipsToBounds = true
    }
    
    func moveToCenterInSuperview() {
        guard let superview else { return }
        center = CGPoint(x: superview.bounds.midX, y: superview.bounds.midY)
    }
}
