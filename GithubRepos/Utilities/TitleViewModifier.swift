//
//  TitleViewModifier.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI

struct TitleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
      content
        .font(.callout)
        .multilineTextAlignment(.center)
        .foregroundColor(.blue)
        .padding(.vertical, 1)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleViewModifier())
    }
}
