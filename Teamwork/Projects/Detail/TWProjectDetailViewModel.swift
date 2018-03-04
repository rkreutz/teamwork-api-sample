//
//  TWProjectDetailViewModel.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Class

class TWProjectDetailViewModel {
    
    // MARK: Computed properties
    
    var projectName: String {
        
        return project.name
    }
    
    var projectDescription: String {
        
        return project.description
    }
    
    var projectLogoUrl: URL? {
        
        return URL(string: project.logoUrlString)
    }
    
    var projectIsStarred: Bool {
        
        return project.isStarred
    }
    
    var projectCreatedAt: String {
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: project.createdOn)
    }
    
    var projectLastChangedAt: String {
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: project.lastChangedOn)
    }
    
    var projectCompany: String {
        
        return project.company.name
    }
    
    var projectCategory: String {
        
        return project.category.name
    }
    
    var projectCategoryColor: UIColor {
        
        return project.category.color
    }
    
    var projectTags: [TWTag] {
        
        return project.tags
    }
    
    // MARK: Private variables
    
    private let project: TWProject
    
    // MARK: Initializers
    
    init(project: TWProject) {
        
        self.project = project
    }
}
