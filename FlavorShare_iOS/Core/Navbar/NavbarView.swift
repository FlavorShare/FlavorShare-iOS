//
//  NavbarView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-06.
//

import SwiftUI

struct NavbarView: View {
    // MARK: VARIABLES
    let user: User
    @State private var selectedIndex = 0
    
    // MARK: BODY
    var body: some View {
        TabView (selection: $selectedIndex) {
            RecipeListView()
                .onAppear() {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            UserView(user: user)
                .onAppear() {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(1)
        }
    }
}

#Preview {
    NavbarView(user: MockData.shared.user)
}
