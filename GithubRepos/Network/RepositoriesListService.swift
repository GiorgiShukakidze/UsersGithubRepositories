//
//  RepositoriesListService.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import Foundation
import Combine

final class RepositoriesListService {
    private let service: NetworkManager
    
    init(with service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchRepositories(user: String, for page: Int) -> AnyPublisher<[Repository], NetworkError> {
        let path = URLRepository.usersRepositories(for: user)
        
        var queryItems = [URLQueryItem]()
        queryItems.append(.init(name: "page", value: "\(page)"))
        queryItems.append(.init(name: "per_page", value: "\(Constants.itemsPerPage)"))
        
        return service.networkRequest(path: path, queryItems: queryItems)
    }
}
