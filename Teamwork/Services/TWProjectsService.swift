//
//  TWProjectsService.swift
//  Teamwork
//
//  Created by Rodrigo Kreutz on 3/3/18.
//  Copyright © 2018 Rodrigo Kreutz. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

// MARK: - Class

class TWProjectsService {
    
    // MARK: Error enum
    
    enum Error: String, Swift.Error {
        
        case invalidUser
        case generic
        case noInternet
        
        var reason: String {
            
            switch self {
                
            case .invalidUser:
                return "Please verify your credentials and try again."
                
            case .generic:
                return "Something went wrong, please try again."
                
            case .noInternet:
                return "It seems your internet connection is off or weak, please try again later."
            }
        }
    }
    
    // MARK: Internal methods (services)
    
    func projects(forUser user: String, withStatus status: TWProject.Status) -> Observable<[TWProject]> {

        // This is a convenience wrapper for the response, defined only in the function's scope
        struct ResponseWrapper: Decodable {
            
            let status: String
            let projects: [TWProject]
            
            enum CodingKeys: String, CodingKey {
                
                case status = "STATUS"
                case projects
            }
            
            init(status: String, projects: [TWProject]) {
                
                self.status = status
                self.projects = projects
            }
            
            init(from decoder: Decoder) throws {
                
                let values = try decoder.container(keyedBy: CodingKeys.self)
                
                let status = try values.decode(String.self, forKey: .status)
                let projects = try values.decode([TWProject].self, forKey: .projects)
                
                self.init(
                    status: status,
                    projects: projects
                )
            }
        }
        
        guard user.isNotEmpty else {
            
            return Observable.error(Error.invalidUser)
        }
        
        // This block of code will be executed whenever the Observable is subscribed
        return Observable.create({ (observer) -> Disposable in
            
            let request = Alamofire.request(
                "\(TWURL.baseHost)/projects.json",
                parameters: ["status": "\(status)"],
                encoding: URLEncoding.default,
                headers: [
                    "Authorization": "Basic \("\(user):".data(using: .utf8)?.base64EncodedString() ?? "")"
                ]
            )
                    
            request
                .validate() // Validates the HTTP status code between 200..<300
                .responseData(completionHandler: { (response) in
                    
                    switch response.result {
                        
                    case .success(let result):
                        do {
                            
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(ResponseWrapper.self, from: result)
                            observer.onNext(response.projects)
                            observer.onCompleted()
                        } catch let error {
                            
                            print("Failed parsing response with error:\n\(error)")
                            observer.onError(Error.generic)
                        }
                        
                    case .failure(let error):
                        switch error {
                            
                        case AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401)):
                            observer.onError(Error.invalidUser)
                            
                        case URLError.notConnectedToInternet:
                            observer.onError(Error.noInternet)
                            
                        default:
                            observer.onError(Error.generic)
                        }
                    }
                })
            
            // This code executes when the observable is disposed
            return Disposables.create {
                
                request.cancel()
            }
        })
    }
}
