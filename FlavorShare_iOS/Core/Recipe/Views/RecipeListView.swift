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
    
    var body: some View {
        VStack(spacing: 0) { // Adjust spacing to 0
            // Horizontal Scroll Bar for Categories
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.cuisineTypes, id: \.self) { category in
                        Text(category)
                            .padding()
                            .background(selectedCategory == category ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal) // Only horizontal padding
            }
            .padding(.top, 10) // Add some top padding to the ScrollView
            
            // Recipe List
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(filteredRecipes) { recipe in
                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                        HStack {
                            if let url = URL(string: recipe.imageURL) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(recipe.title)
                                    .font(.headline)
                                Text(recipe.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle()) // Use plain list style to reduce padding
            }
        }
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    let feedback = AuthService.shared.signOut()
                    if let errorMessage = feedback {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }) {
                    Text("Sign Out")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RecipeEditorView(isNewRecipe: true)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(AuthViewModel())
    }
}
