//
//  RepositoriesTabView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 12.08.21.
//

import SwiftUI
import Combine

struct RepositoriesTabView: View {
    var body: some View {
        TabView {
            RepositoriesListView()
                .tabItem {
                    Label("Repositories", systemImage: "list.dash")
                }
            StarredRepositoriesView()
                .tabItem {
                    Label("Starred", systemImage: "star")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesTabView()
    }
}
