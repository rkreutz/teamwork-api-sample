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
    
    // MARK: Private computed properties
    
    private var noTagsLabel: UILabel {
        
        let label = EdgeInsetLabel()
        label.text = "This project has no tags 😒"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }

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
    
    @IBOutlet weak private var collectionView: UICollectionView! {
        
        didSet {
            
            collectionView.dataSource = self
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: 100, height: 40)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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
        
        if viewModel.projectTags.isEmpty {
            
            collectionView.backgroundView = noTagsLabel
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TWProjectDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.projectTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TWProjectTagCollectionViewCell.identifier, for: indexPath)
        
        guard
            let tagCell = cell as? TWProjectTagCollectionViewCell,
            indexPath.item >= 0,
            indexPath.item < viewModel.projectTags.count
            else { return cell }
        
        tagCell.configure(withTag: viewModel.projectTags[indexPath.item])
        return tagCell
    }
}
