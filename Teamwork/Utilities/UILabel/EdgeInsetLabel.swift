//
//  EdgeInsetLabel.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/4/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Class

class EdgeInsetLabel: UILabel {

    // MARK: Internal variables
    
    var textInsets = UIEdgeInsets.zero {
        
        didSet {
            
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: Overriden methods
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        
        let invertedInsets = UIEdgeInsets(
            top: -textInsets.top,
            left: -textInsets.left,
            bottom: -textInsets.bottom,
            right: -textInsets.right
        )
        
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
    }
}
