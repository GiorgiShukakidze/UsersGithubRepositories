//
//  RepositoryDetailsViewModel.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI
import Combine


class RepositoryDetailsViewModel: ObservableObject {
    @Published var repository: Repository?
    @Published var state: State = .initial
    
    var repositoryUrl: URL? {
        if let urlString = repository?.repositoryUrl {
            return URL(string: urlString)
        }
        
        return nil
    }
    
    var creationTime: String {
        guard let date = repository?.dateCreated else { return "n/a" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    var isStarred: Bool {
        guard let repo = repository else { return false }

        return PersistanceManager.shared.isStarred(repository: repo)
    }
    
    private let repoUrl: String
    private let repositoryService = RepositoryService()
    private var repositoryCancellable: AnyCancellable?
    
    init(repoUrl: String) {
        self.repoUrl = repoUrl
    }
    
    func fetchRepositoryDetails() {
        state = .loading
        repositoryCancellable?.cancel()
        
        repositoryCancellable = repositoryService.fetchRepositoryDetails(for: repoUrl)
            .catch {[weak self] error -> AnyPublisher<Repository, Never> in
                self?.state = .error(error.localizedDescription)
                
                return .init(Empty())
            }
            .sink {[weak self] repo in
                self?.repository = repo
                self?.state = .complete
            }
    }
    
    func toggleStar() {
        guard let repo = repository else { return }
        
        PersistanceManager.shared.toggleRepositoryStar(for: repo)
        objectWillChange.send()
    }
    
    enum State: Equatable {
        case initial
        case loading
        case complete
        case error(String)
    }
}
