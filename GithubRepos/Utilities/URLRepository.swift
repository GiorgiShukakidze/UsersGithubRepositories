//
//  URLRepository.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 12.08.21.
//

import Foundation

enum URLRepository {
    static let baseUrl: String = "https://api.github.com"
    static func usersRepositories(for user: String) -> String { "/users/\(user)/repos"}
}
