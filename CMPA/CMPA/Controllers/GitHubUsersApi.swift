//
//  GitHubUsersController.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import RxSwift

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum GitHubServiceError: Error {
    case offline
    case githubLimitReached
    case networkError
}

struct GitHubUsersApiController {
    func getUsers(by query: String) -> Observable<GitHubResponse<User>> {
        guard let url = URL(string: "https://api.github.com/search/users?q=\(query)") else {
            fatalError("Could not parse Url")
        }
        
        let appClient = AppClient()
        
        return appClient.get(request: URLRequest(url: url))
    }
}
