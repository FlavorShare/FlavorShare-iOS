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
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack (){
            ZStack {
                // Background Image
                Image("Background")
                    .resizable()
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
                
                BlurView(style: .regular)
                    .frame(width: screenWidth, height: screenHeight)
                
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: screenWidth, height: screenHeight)
                
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
                            if let imageURL = AuthService.shared.currentUser?.profileImageURL {
                                if imageURL != "" {
                                    RemoteImageView(fileName: imageURL, width: screenWidth / 5, height: screenWidth / 5)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                        .shadow(radius: 5)
                                        .padding(.trailing, 5)
                                }
                                
                               
                                
                            }
                            
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
                        .padding(.leading)
                        
                        // Custom SearchBar
                        HStack (alignment: .center, spacing: 0) {
                            SearchBar(searchText: $viewModel.searchText)
                                .padding()
                                .onChange(of: viewModel.searchText) {
                                    viewModel.filterRecipes()
                                }
                            
                            Button(action: {
                                viewModel.likeFilter.toggle()
                                viewModel.filterRecipes()
                            }) {
                                Image(systemName: viewModel.likeFilter ? "heart.fill" : "heart")
                                    .foregroundColor(.white)
                                    .padding(.trailing)
                                    .font(.title)
                            }
                        }
                        
                        // Horizontal Scroll Bar for Categories
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.cuisineTypes, id: \.self) { category in
                                    Text(category)
                                        .padding(.horizontal)
                                        .padding(.vertical, 5)
                                        .background(viewModel.selectedCategory == category ? Color.black.opacity(0.8) : Color.black.opacity(0.3))
                                        .fontWeight(viewModel.selectedCategory == category ? .bold : .regular)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            viewModel.selectedCategory = category
                                            viewModel.filterRecipes()
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
                                ForEach(viewModel.filteredRecipes) { recipe in
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        RecipeSquare(recipe: recipe, size: .profile)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, screenHeight / 15)
                        }
                        
                        Spacer()
                    } // VStack
                    .padding(.bottom, 150)
                    
                } // ScrollView
                .refreshable {
                    viewModel.fetchRecipes()
                }
                .onAppear() {
                    viewModel.fetchRecipes()
                }
                
            } // ZStack
            .ignoresSafeArea(.container, edges: .top)
        } // NavigationStack
    } // Body
}

#Preview {
    RecipeListView()
        .environmentObject(AuthViewModel())
}
