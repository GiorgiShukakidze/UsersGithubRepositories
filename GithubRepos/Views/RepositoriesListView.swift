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
                    List {
                        ForEach(repositoriesViewModel.repositories, id: \.id) { repo in
                            RepositoryListCellView(repo: repo, avatar: repositoriesViewModel.avatarImage(for: repo.owner))
                        }
                        if repositoriesViewModel.hasMore {
                            loadingMoreCell
                            .onAppear {
                                repositoriesViewModel.fetchNextPage()
                            }
                        }
                    }
                    .overlay(loadingOverlay)
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
        .onChange(of: repositoriesViewModel.state) { state in
            handleStateChange(state)
        }
        .alert(item: $alert) { alert in
            alert.alert()
        }
    }
    
    @ViewBuilder
    var loadingOverlay: some View {
        if repositoriesViewModel.state == .loading {
            Color(.gray)
                .opacity(0.2)
        }
    }
    
    var loadingMoreCell: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("Loading more...")
                .foregroundColor(.blue)
            Spacer()
        }
    }
    
    private func handleStateChange(_ state: UsersRepositoriesViewModel.State) {
        switch state {
        case .error(let description):
            alert = .init(title: "Error Loading Data", message: description)
        default: break
        }
    }
}
