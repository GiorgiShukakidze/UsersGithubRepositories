//
//  RepositoryListCellView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 14.08.21.
//

import SwiftUI

struct RepositoryListCellView: View {
    let repo: Repository
    let avatar: UIImage?
    
    var body: some View {
        NavigationLink(
            destination: RepositoryDetailsView(repositoryViewModel: .init(repoUrl: repo.urlString)),
            label: {
                HStack {
                    avatarImage
                    VStack {
                        Text("User")
                            .bold()
                            .titleStyle()
                        Text("\(repo.owner.name)")
                            .font(.callout)
                        Text("Repository")
                            .bold()
                            .titleStyle()
                        Text("\(repo.name)")
                            .font(.callout)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            })
    }
    
    var avatarImage: some View {
        var image: Image
        if let uiimage = avatar {
            image = Image(uiImage: uiimage)
        } else {
            image = Image(systemName: "photo")
        }
        
        return image
            .resizable()
            .frame(maxWidth: 60, maxHeight: 60, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }
}
