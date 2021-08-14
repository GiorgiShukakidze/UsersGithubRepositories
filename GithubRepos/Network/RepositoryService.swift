//
//  RepositoryService.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import Foundation
import Combine

final class RepositoryService {
    private let service: NetworkManager
    
    init(with service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    func fetchRepositoryDetails(for urlString: String) -> AnyPublisher<Repository, NetworkError> {
        let url = URL(string: urlString)
        
        return service.networkRequest(for: url)
    }
}
