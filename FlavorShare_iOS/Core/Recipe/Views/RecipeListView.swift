//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var selectedCategory: String = "All"
    
    var filteredRecipes: [RecipeAPIService.Recipe] {
        if selectedCategory == "All" {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter { $0.type == selectedCategory }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                    .padding()
                }
                
                // Recipe List
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List(filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeView(recipe: convertToRecipe(apiRecipe: recipe))) {
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
                    .navigationTitle("Recipes")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: RecipeEditorView(isNewRecipe: true)) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
