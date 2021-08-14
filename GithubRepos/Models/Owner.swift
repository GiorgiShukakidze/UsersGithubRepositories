//
//  Owner.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 12.08.21.
//

import Foundation

struct Owner: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let avatarUrlString: String
    
    var avatarUrl: URL? { URL(string: avatarUrlString) }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarUrlString = "avatar_url"
    }
}
