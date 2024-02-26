//
//  UIColor + Extension.swift
//  MiniCV
//
//  Created by Антон Стафеев on 26.02.2024.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    static let dynamicBackgroundColor = UIColor.dynamic(
        light: UIColor(hex: 0xF3F3F5),
        dark: UIColor(hex: 0x130f40)
    )
    
    static let dynamicSkillsViewColor = UIColor.dynamic(
        light: UIColor(hex: 0xFFFFFF),
        dark: UIColor(hex: 0x30336b)
    )
    
    private static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor(dynamicProvider: {
            switch $0.userInterfaceStyle {
            case .dark:
                return dark
            case . light, .unspecified:
                return light
            @unknown default:
                assertionFailure("Неизвестный userInterfaceStyle: \($0.userInterfaceStyle)")
                return light
            }
        })
    }
}
