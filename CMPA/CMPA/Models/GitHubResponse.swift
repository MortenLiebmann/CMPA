//
//  GitHubResponse.swift
//  CMPA
//
//  Created by Morten Liebmann Andersen on 18/09/2018.
//  Copyright © 2018 Morten Liebmann Andersen. All rights reserved.
//

import Foundation

struct GitHubResponse<T: Codable>:Codable {
    var Total: Int?
    var Incomplete: Bool?
    var Items: [T]?
    
    private enum CodingKeys: String, CodingKey {
        case Total = "total_count"
        case Incomplete = "incomplete_results"
        case Items = "items"
    }
}
