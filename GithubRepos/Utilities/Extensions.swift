//
//  Extensions.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
