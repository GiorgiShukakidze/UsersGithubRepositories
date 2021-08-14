//
//  Repository.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 12.08.21.
//

import Foundation

struct Repository: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let urlString: String
    let dateCreated: Date
    let description: String?
    let language: String?
    let owner: Owner
    let repositoryUrl: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        urlString = try container.decode(String.self, forKey: .urlString)
        dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        description = try? container.decode(String.self, forKey: .description)
        language = try? container.decode(String.self, forKey: .language)
        owner = try container.decode(Owner.self, forKey: .owner)
        repositoryUrl = try container.decode(String.self, forKey: .repositoryUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case urlString = "url"
        case dateCreated = "created_at"
        case description
        case language
        case owner
        case repositoryUrl = "svn_url"
    }
}
