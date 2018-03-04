//
//  TWProjectTableViewCell.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Class

class TWProjectTableViewCell: UITableViewCell {

    // MARK: Static variables
    
    static let identifier = "TWProjectTableViewCell"
    
    // MARK: IBOutlets
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var statusLabel: UILabel!
    
    // MARK: Internal methods
    
    func configure(withProject project: TWProject) {
        
        self.nameLabel.text = project.name
        self.starImageView.isHidden = !project.isStarred
        self.statusLabel.text = project.status.title
        self.statusLabel.textColor = project.status.color
    }
}
