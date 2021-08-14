//
//  RepositoriesListView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI
import Combine

struct RepositoriesListView: View {
    @ObservedObject var repositoriesViewModel = UsersRepositoriesViewModel()
    
    @State private var cancellables = Set<AnyCancellable>()
    @State private var alert: CustomAlert?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBarView(searchText: $repositoriesViewModel.userName)
                    Spacer()
                    List(repositoriesViewModel.repositories, id: \.id) { repo in
                        RepositoryListCellView(repo: repo, avatar: repositoriesViewModel.avatarImage(for: repo.owner))
                            .onAppear {
                                if repositoriesViewModel.repositories.last == repo {
                                    repositoriesViewModel.fetchNextPage()
                                }
                            }
                    }
                    .onAppear { UIScrollView.appearance().bounces = true }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                if repositoriesViewModel.state == .loading {
                    ProgressView().scaleEffect(2)
                }
                
                if repositoriesViewModel.state == .idle {
                    Text("Enter GitHub Username in SearchBar...")
                }
            }
        }
        .onAppear { repositoriesViewModel.setupBindings() }
        .onChange(of: repositoriesViewModel.state) { status in
            switch status {
            case .error(let description):
                alert = .init(title: "Error Loading Data", message: description)
            default: break
            }
        }
        .alert(item: $alert) { alert in
            alert.alert()
        }
    }
}
