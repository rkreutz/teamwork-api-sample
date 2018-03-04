//
//  TWProject.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import UIKit

// MARK: - Struct

struct TWProject {
    
    // MARK: Status enum
    
    enum Status: String {
        
        case unknown
        case active
        case archived
        case current
        case late
        case completed
        case all
        
        var title: String {
            
            switch self {
                
            case .active:
                return "Active"
                
            case .archived:
                return "Archived"
                
            case .current:
                return "Current"
                
            case .late:
                return "Late"
                
            case .completed:
                return "Completed"
                
            default:
                return ""
            }
        }
        
        var color: UIColor {
            
            switch self {
            
            case .active:
                return .purple
                
            case .archived:
                return .orange
                
            case .current:
                return .blue
                
            case .late:
                return .red
            
            case .completed:
                return .green
                
            default:
                return .black
            }
        }
    }
    
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
    
    // MARK: Private variables
    
    private let statusString: String
    
    // MARK: Computed properties
    
    var status: Status {
        
        return Status(rawValue: statusString) ?? .unknown
    }
}

// MARK: - Decodable conformance

extension TWProject: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case description
        case logoUrlString = "logo"
        case isStarred = "starred"
        case createdOn = "created-on"
        case lastChangedOn = "last-changed-on"
        case category
        case tags
        case company
        case status
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try values.decode(String.self, forKey: .id)
        let name = try values.decode(String.self, forKey: .name)
        let description = try values.decode(String.self, forKey: .description)
        let logoUrlString = try values.decodeIfPresent(String.self, forKey: .logoUrlString) ?? ""
        let isStarred = try values.decode(Bool.self, forKey: .isStarred)
        let createdOnString = try values.decode(String.self, forKey: .createdOn)
        let lastChangedOnString = try values.decode(String.self, forKey: .lastChangedOn)
        let category = try values.decode(TWCategory.self, forKey: .category)
        let tags = try values.decode([TWTag].self, forKey: .tags)
        let company = try values.decode(TWCompany.self, forKey: .company)
        let statusString = try values.decode(String.self, forKey: .status)
        
        guard let createdOnDate = DateFormatter.iso8601.date(from: createdOnString) else {
            
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.createdOn,
                in: values,
                debugDescription: "'\(CodingKeys.createdOn.rawValue)' is not a valid date string."
            )
        }
        
        guard let lastChangedOnDate = DateFormatter.iso8601.date(from: lastChangedOnString) else {
            
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.lastChangedOn,
                in: values,
                debugDescription: "'\(CodingKeys.lastChangedOn.rawValue)' is not a valid date string."
            )
        }
        
        self.init(
            id: id,
            name: name,
            description: description,
            logoUrlString: logoUrlString,
            isStarred: isStarred,
            createdOn: createdOnDate,
            lastChangedOn: lastChangedOnDate,
            category: category,
            tags: tags,
            company: company,
            statusString: statusString
        )
    }
}
