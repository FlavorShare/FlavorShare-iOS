

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
                
                MealPlanningView()
                    .opacity(selectedIndex == 2 ? 1 : 0)
                    .animation(.easeInOut, value: selectedIndex)
                
                // TODO: SHOW ONLY IF USER IS ADMIN (MODIFY TO BECOME ADMIN PANEL)
//                AddFoodItemView()
//                    .opacity(selectedIndex == 3 ? 1 : 0)
//                    .animation(.easeInOut, value: selectedIndex)
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
                // TODO: SHOW ONLY IF USER IS ADMIN (MODIFY TO BECOME ADMIN PANEL)
//                // ********** Add Food Item View **********
//                Button(action: {
//                    withAnimation {
//                        selectedIndex = 3
//                    }
//                }) {
//                    VStack {
//                        Image(systemName: "plus.circle")
//                    }
//                }
//                .foregroundColor(selectedIndex == 3 ? .black.opacity(0.8) : .gray)
//                .padding(.horizontal)
                
                // ******* MealPlanningView *******
                Button(action: {
                    withAnimation {
                        selectedIndex = 2
                    }
                }) {
                    VStack {
                        Image(systemName: "calendar")
                    }
                }
                .foregroundColor(selectedIndex == 2 ? .black.opacity(0.8) : .gray)
                .padding(.horizontal)
                
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
                .foregroundColor(selectedIndex == 0 ? .black.opacity(0.8) : .gray)
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
                .foregroundColor(selectedIndex == 1 ? .black.opacity(0.8) : .gray)
                .padding(.horizontal)
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .background(Color.white.opacity(0.2))
            .cornerRadius(25)
            .shadow(radius: 5)
    }
}

#Preview {
    NavbarView(user: MockData.shared.user)
}
