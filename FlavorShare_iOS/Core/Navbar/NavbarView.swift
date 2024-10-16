

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
    
    init(user: User) {
        self.user = user
    }
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                RecipeListView()
                    .opacity(selectedIndex == 0 ? 1 : 0)
                    .animation(.easeInOut, value: selectedIndex)
                UserView(user: user)
                    .opacity(selectedIndex == 1 ? 1 : 0)
                    .animation(.easeInOut, value: selectedIndex)
            }
            .animation(.easeInOut, value: selectedIndex)
            
            CustomTabBar(selectedIndex: $selectedIndex)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            // ******* RecipeListView *******
            Button(action: {
                withAnimation {
                    selectedIndex = 0
                }
            }) {
                VStack {
                    Image(systemName: "house.fill")
                }
            }
            .foregroundColor(selectedIndex == 0 ? .mint : .gray)
            .padding(.horizontal)
            
            // ********** UserView **********
            Button(action: {
                withAnimation {
                    selectedIndex = 1
                }
            }) {
                VStack {
                    Image(systemName: "person.fill")
                }
            }
            .foregroundColor(selectedIndex == 1 ? .mint : .gray)
            .padding(.horizontal)
            
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(25)
        .shadow(radius: 5)
    }
}

#Preview {
    NavbarView(user: MockData.shared.user)
}
