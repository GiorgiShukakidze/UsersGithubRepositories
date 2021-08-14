//
//  SupportingViews.swift
//  GithubRepos
//
//  Created by Giorgi Shukakidze on 13.08.21.
//

import SwiftUI

struct CustomAlert: Identifiable {
    var id: String
    var alert: () -> Alert
    
    init(title: String, message: String) {
        self.id = title + message
        alert = { Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK"))) }
    }
}
