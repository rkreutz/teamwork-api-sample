//
//  TWProjectDetailViewController.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Class

class TWProjectDetailViewController: UIViewController {
    
    // MARK: Internal variables
    
    var viewModel: TWProjectDetailViewModel!

    // MARK: IBOutlets
    
    @IBOutlet weak private var imageView: UIImageView! {
        
        didSet {
            
            imageView.kf.indicatorType = .activity
        }
    }
    
    @IBOutlet weak private var gradientView: UIView! {
        
        didSet {
            
            let layer = CAGradientLayer()
            layer.frame = gradientView.bounds
            layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            layer.locations = [NSNumber(value: 0.0), NSNumber(value: 1.0)]
            gradientView.layer.mask = layer
        }
    }
    
    @IBOutlet weak private var createdAtLabel: UILabel!
    @IBOutlet weak private var lastChangedAtLabel: UILabel!
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var companyLabel: UILabel!
    @IBOutlet weak private var categoryTitleLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    // MARK: Overriden methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Private methods
    
    private func configureView() {
        
        title = viewModel.projectName
        descriptionLabel.text = viewModel.projectDescription
        starImageView.isHidden = !viewModel.projectIsStarred
        createdAtLabel.text = viewModel.projectCreatedAt
        lastChangedAtLabel.text = viewModel.projectLastChangedAt
        companyLabel.text = viewModel.projectCompany
        
        if viewModel.projectCategory.isNotEmpty {
        
            categoryTitleLabel.textColor = viewModel.projectCategoryColor
            categoryLabel.text = viewModel.projectCategory
            categoryLabel.textColor = viewModel.projectCategoryColor
        } else {
            
            categoryTitleLabel.isHidden = true
            categoryLabel.isHidden = true
        }
        
        if let logoUrl = viewModel.projectLogoUrl {
            
            imageView.kf.setImage(with: logoUrl, options: [.transition(.flipFromBottom(0.2))])
        }
    }
}
