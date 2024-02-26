//
//  UIView + Extension.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
