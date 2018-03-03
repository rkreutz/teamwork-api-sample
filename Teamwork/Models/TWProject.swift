//
//  TWProject.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import Foundation

// MARK: - Struct

struct TWProject {
    
    // MARK: Internal variables
    
    let id: String
    let name: String
    let description: String
    let logoUrlString: String
    let isStarred: Bool
    let createdOn: Date
    let lastChangedOn: Date
    let category: TWCategory
    let tags: [TWTag]
    let company: TWCompany
}
