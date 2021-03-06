//
//  GitHubUsersController.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import RxSwift

struct GitHubUsersApiController: AppClientDelegate {
    func getUsers(by urlString: String, key: String) -> Observable<[User]> {
        guard let url = URL(string: urlString) else {
            return .empty()
        }
        
        return appClient.get(request: URLRequest(url: url), key: key)
    }
    
    func searchUsers(by query: String, key: String) -> Observable<GitHubResponse<User>> {
        guard let url = URL(string: "https://api.github.com/search/users?q=\(query)") else {
            return .empty()
        }
        
        return appClient.get(request: URLRequest(url: url), key: key)
    }
}
