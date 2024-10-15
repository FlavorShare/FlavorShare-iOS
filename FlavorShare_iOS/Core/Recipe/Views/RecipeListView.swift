//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedCategory: String = "All"
    
    var filteredRecipes: [Recipe] {
        if selectedCategory == "All" {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter { $0.type == selectedCategory }
        }
    }
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Image
                Image("Background")
                    .resizable()
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
//                    .ignoresSafeArea(.container, edges: .top)

                BlurView(style: .regular)
                    .frame(width: screenWidth, height: screenHeight)
//                    .ignoresSafeArea(.container, edges: .top)

                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: screenWidth, height: screenHeight)
//                    .ignoresSafeArea(.container, edges: .top)

                ScrollView {
                    VStack(spacing: 0) {
                        
                        // App Logo
                        Image("AppLogo")
                            .resizable()
                            .frame(width: screenWidth / 4, height: screenWidth / 4)
                            .padding(.top, 50)
                        
                        // Welcome Message
                        let userFirstName = AuthService.shared.currentUser?.firstName ?? "User"
                        HStack {
                            RemoteImageView(fileName: AuthService.shared.currentUser?.profileImageURL ?? "Image", width: screenWidth / 5, height: screenWidth / 5)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 5)
                                .padding(.leading)
                                .padding(.trailing, 5)
                            
                            VStack (alignment: .leading) {
                                Spacer()
                                
                                Text("Hi, \(userFirstName)!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text("What's cooking today?")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                        }
                        
                        // Custom SearchBar
                        SearchBar(searchText: $viewModel.searchText)
                            .padding()
                        
                        // Horizontal Scroll Bar for Categories
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.cuisineTypes, id: \.self) { category in
                                    Text(category)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(selectedCategory == category ? Color.black.opacity(0.8) : Color.black.opacity(0.5))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            selectedCategory = category
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Recipe List
                        if viewModel.isLoading {
                            ProgressView()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                                .multilineTextAlignment(.leading)
                        } else {
                            let columns = [
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10)
                            ]
                            
                            // Recipe Lists
                            LazyVGrid(columns: columns, spacing: screenWidth / 6) {
                                ForEach(filteredRecipes) { recipe in
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        RecipeSquare(recipe: recipe, size: .profile)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, screenHeight / 15)
                            .padding(.bottom, screenHeight / 5)
                        }
                        
                        Spacer()
                    } // VStack
                    
                } // ScrollView
//                .refreshable {
//                    viewModel.fetchRecipes()
//                }
                .ignoresSafeArea(.container, edges: .top)
            } // ZStack
            .ignoresSafeArea(.container, edges: .top)
        } // NavigationStack
        .ignoresSafeArea(.container, edges: .top)
    } // Body
}

#Preview {
    RecipeListView()
        .environmentObject(AuthViewModel())
}
