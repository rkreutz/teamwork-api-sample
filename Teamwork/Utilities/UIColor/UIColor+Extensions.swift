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
        guard rawHex.compare("^[0-9A-Fa-f]{6}$", options: .regularExpression) == .orderedSame else { return nil }
        
        var rgbValue: UInt32 = 0
        Scanner(string: rawHex).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
}
