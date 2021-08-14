//
//  SearchBarView.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String // Can be passed directly to textfield to search for everytime user types new word.
    
    @State private var editing = false
    @State private var text: String = "" // No need if 'searchText' is bound to TextField
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(.lightGray))
                    .frame(maxWidth: 25)
                TextField("Username...", text: $text, onCommit:  {
                    hideKeyboard()
                    searchText = text
                })
                    .padding(.vertical, 6)

                if editing {
                    Button(action: {
                        searchText = ""
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.lightGray))
                            .padding(.trailing, 6)
                    }
                }
            }
            .background(Color(.init(gray: 0.6, alpha: 0.2)))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .onTapGesture {
                editing = true
            }
            
            if editing {
                Button(action: {
                    searchText = ""
                    text = ""
                    editing = false
                    
                    hideKeyboard()
                }) {
                    Text("Cancel")
                        .font(.callout)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("Test"))
    }
}
