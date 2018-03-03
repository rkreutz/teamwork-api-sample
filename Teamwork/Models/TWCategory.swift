//
//  TWCategory.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Struct

struct TWCategory {
    
    // MARK: Internal variables
    
    let id: String
    let name: String
    
    // MARK: Private variables
    
    private let colorString: String
    
    // MARK: Computed properties
    
    var color: UIColor {
        
        return .black
    }
}
