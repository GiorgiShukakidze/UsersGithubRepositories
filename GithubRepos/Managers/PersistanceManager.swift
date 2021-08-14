//
//  PersistanceManager.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 14.08.21.
//

import Foundation

final class PersistanceManager {
    static var shared = PersistanceManager()
    
    private let storage = UserDefaults.standard
    
    func toggleRepositoryStar(for repository: Repository) {
        
        isStarred(repository: repository) ? remove(repository: repository) : insert(repository: repository)
    }
    
    func getRepositories() -> Set<Repository> {
        if let reposData = storage.data(forKey: Constants.repositoriesKey),
           let repositories = try? JSONDecoder().decode(Set<Repository>.self, from: reposData) {
            return repositories
        } else {
            return []
        }
    }
    
    func isStarred(repository: Repository) -> Bool {
        getRepositories().contains(repository)
    }
    
    private func insert(repository: Repository) {
        var repos = getRepositories()
        repos.insert(repository)
        
        save(repositories: repos)
    }
    
    private func remove(repository: Repository) {
        var repos = getRepositories()
        repos.remove(repository)
        
        save(repositories: repos)
    }
    
    private func save(repositories: Set<Repository>) {
        let data = try? JSONEncoder().encode(repositories)
        storage.setValue(data, forKey: Constants.repositoriesKey)
    }
}
