//
//  GitHubRepositoriesApi.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation
import RxSwift

struct GitHubRepositoriesApiController {
    var appClient = AppClient()
    func getRepositories(by urlString: String, key: String) -> Observable<[Repository]> {
        guard let url = URL(string: urlString) else {
            return .empty()
        }
        
        return appClient.get(request: URLRequest(url: url), key: key)
    }
    
    func searchRepositories(by query: String, key: String) -> Observable<GitHubResponse<Repository>> {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") else {
            return .empty()
        }
        
        return appClient.get(request: URLRequest(url: url), key: key)
    }
}
