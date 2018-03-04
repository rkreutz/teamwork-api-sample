//
//  ProcessInfo+Extensions.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import Foundation

// MARK: - ProcessInfo extensions

extension ProcessInfo {
    
    var apiKey: String {
        
        return self.environment["API_KEY"] ?? ""
    }
}
