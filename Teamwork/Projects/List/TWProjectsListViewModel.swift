//
//  TWProjectsListViewModel.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Class

class TWProjectsListViewModel {
    
    // MARK: Internal variables
    
    var projects: [TWProject] = []
    
    // MARK: Private variables
    
    private let projectsService = TWProjectsService()
    
    // MARK: Internal methods
    
    func updateProjects() -> Observable<[TWProject]> {
        
        return projectsService.projects(forUser: ProcessInfo.processInfo.apiKey, withStatus: .all)
            .map({ $0.sorted(by: { $0.name.compare($1.name) == .orderedAscending }) })
            .do(onNext: { [weak self] in self?.projects = $0 })
    }
}
