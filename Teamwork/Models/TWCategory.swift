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

// MARK: - Decodable conformance

extension TWCategory: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case colorString = "color"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try values.decode(String.self, forKey: .id)
        let name = try values.decode(String.self, forKey: .name)
        let colorString = try values.decode(String.self, forKey: .colorString)
        
        self.init(
            id: id,
            name: name,
            colorString: colorString
        )
    }
}
