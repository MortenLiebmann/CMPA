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
    var Repos_Url: String?
    
    private enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Repos_Url = "repos_url"
    }
}
