//
//  User.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation

struct User: Codable {
    var Id: Int?
    var RepositoryUrl: String?
    var UserType: String?
    var UserLogin: String?
    var AvatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case Id = "id"
        case RepositoryUrl = "repos_url"
        case UserType = "type"
        case UserLogin = "login"
        case AvatarUrl = "avatar_url"
    }
}
