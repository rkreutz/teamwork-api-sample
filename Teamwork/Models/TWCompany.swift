//
//  TWCompany.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import Foundation

// MARK: - Struct

struct TWCompany {
    
    // MARK: Internal variables
    
    let id: String
    let name: String
}

// MARK: - Decodable conformance

extension TWCompany: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try values.decode(String.self, forKey: .id)
        let name = try values.decode(String.self, forKey: .name)
        
        self.init(
            id: id,
            name: name
        )
    }
}
