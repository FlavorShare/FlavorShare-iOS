//
//  ContentView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                AuthView()
            } else if let user = viewModel.currentUser {
                NavbarView(user: user)
            } else {
                // Try to retrieve user
                ProgressView()
                    .onAppear {
                        viewModel.checkAuthState()
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
