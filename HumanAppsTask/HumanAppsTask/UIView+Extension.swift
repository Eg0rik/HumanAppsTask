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
            i.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(i)
        }
    }
}
