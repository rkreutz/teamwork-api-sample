//
//  UIColor+Extensions.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: UIColor extensions

extension UIColor {
    
    convenience init?(fromHex str: String) {
        
        let rawHex = str.replacingOccurrences(of: "#", with: "")
        guard rawHex.range(of: "^[0-9A-Fa-f]{6}$", options: .regularExpression) != nil else { return nil }
        
        var rgbValue: UInt32 = 0
        Scanner(string: rawHex).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
    
    var contrastingWhite: UIColor {
        
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        let contrast: CGFloat = luminance < 0.5 ? 0.0 : 1.0
        
        return UIColor(white: contrast, alpha: 1.0)
    }
}
