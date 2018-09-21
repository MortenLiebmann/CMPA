//
//  Repository.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 17/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation

struct Repository: Codable {
    var Id: Int?
    var Owner: User?
    var Name: String?
    var FullName: String?
    var Language: String?
    var Description: String?
    var Score: Double?
    var Stars: Int?
    var HtmlUrl: String?
    var CreatedAt: Date?
    var Forks: Int?
    var StargazersUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case Id = "id"
        case Owner = "owner"
        case Name = "name"
        case FullName = "full_name"
        case Description = "description"
        case Language = "language"
        case Score = "score"
        case Stars = "stargazers_count"
        case HtmlUrl = "html_url"
        case CreatedAt = "created_at"
        case Forks = "forks"
        case StargazersUrl = "stargazers_url"
    }
}
