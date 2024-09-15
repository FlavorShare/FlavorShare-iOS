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
        NavigationView {
            if viewModel.userSession == nil {
                AuthView()
            } else if viewModel.currentUser != nil {
                RecipeListView()
            }
        }
    }
}

#Preview {
    ContentView()
}
