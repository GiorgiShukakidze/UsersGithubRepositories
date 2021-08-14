//
//  StarredRepositoriesView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 14.08.21.
//

import SwiftUI

struct StarredRepositoriesView: View {
    @ObservedObject var repositoriesViewModel = StarredRepositoriesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List(repositoriesViewModel.repositories, id: \.id) { repo in
                        RepositoryListCellView(repo: repo, avatar: repositoriesViewModel.avatarImage(for: repo.owner))
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .onAppear { repositoriesViewModel.fetchRepos() }
                
                if repositoriesViewModel.repositories.isEmpty {
                    Text("There are no starred repositories")
                }
            }
        }
    }
}

struct StarredReposView_Previews: PreviewProvider {
    static var previews: some View {
        StarredRepositoriesView()
    }
}
