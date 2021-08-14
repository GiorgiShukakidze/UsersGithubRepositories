//
//  StarredRepositoriesViewModel.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 14.08.21.
//

import SwiftUI
import Combine

class StarredRepositoriesViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    
    func fetchRepos() {
        repositories = Array(PersistanceManager.shared.getRepositories())
    }
    
    func avatarImage(for user: Owner) -> UIImage? {
        if let url = user.avatarUrl,
           let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
}
