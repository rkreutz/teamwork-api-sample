//
//  TWProjectTagCollectionViewCell.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/4/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Class

class TWProjectTagCollectionViewCell: UICollectionViewCell {
    
    // MARK: Static variables
    
    static let identifier = "TWProjectTagCollectionViewCell"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var tagView: UIView!
    @IBOutlet weak private var tagLabel: UILabel!
    
    // MARK: Overriden methods
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        tagView.layer.cornerRadius = ceil(tagView.bounds.height / 2) - 1.0
    }
    
    // MARK: Internal methods
    
    func configure(withTag tag: TWTag) {
        
        tagView.backgroundColor = tag.color
        tagLabel.text = tag.name
        tagLabel.textColor = tag.color.contrastingWhite
    }
}
