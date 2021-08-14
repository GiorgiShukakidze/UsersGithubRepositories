//
//  RepositoryDetailsView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI

struct RepositoryDetailsView: View {
    @ObservedObject var repositoryViewModel: RepositoryDetailsViewModel
    @State private var alert: CustomAlert?

    var body: some View {
        ZStack {
            VStack {
                Text("Date Created")
                    .bold()
                    .titleStyle()
                Text("\(repositoryViewModel.creationTime)")
                    .padding(.bottom, 20)
                if let language = repositoryViewModel.repository?.language {
                    Text("Language")
                        .bold()
                        .titleStyle()
                    Text("\(language)")
                        .padding(.bottom, 20)
                }
                if let description = repositoryViewModel.repository?.description {
                    Text("Description")
                        .bold()
                        .titleStyle()
                    ScrollView {
                        Text("\(description)")
                    }
                    .onAppear { UIScrollView.appearance().bounces = false }
                }
                
                
                if let url = repositoryViewModel.repositoryUrl {
                    Spacer()
                    Link(destination: url, label: {
                        Text("Open Repo")
                    })
                    .padding(.all, 15)
                    .background(RoundedRectangle(cornerRadius: 15.0).foregroundColor(Color(.systemGray6)))
                    .padding(.all, 15)
                }
            }
            .onAppear {
                repositoryViewModel.fetchRepositoryDetails()
            }
            
            if repositoryViewModel.state == .loading {
                ProgressView().scaleEffect(2)
            }
        }
        .onChange(of: repositoryViewModel.state) { status in
            switch status {
            case .error(let description):
                alert = .init(title: "Error Loading Data", message: description)
            default: break
            }
        }
        .alert(item: $alert) { alert in
            alert.alert()
        }
        .navigationBarItems(trailing: starItem)
    }
    
    var starItem: some View {
        Button(action: {
            repositoryViewModel.toggleStar()
        }, label: {
            Image(systemName: repositoryViewModel.isStarred ? "star.fill" : "star")
        })
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(repositoryViewModel: .init(repoUrl: "https://api.github.com/repos/GiorgiShukakidze/Calculator"))
    }
}
