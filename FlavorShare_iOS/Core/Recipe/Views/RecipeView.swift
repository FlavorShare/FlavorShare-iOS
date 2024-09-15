//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeView: View {
    @State var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Recipe Image
                if (recipe.imageURL != "") {
                    let url = URL(string: recipe.imageURL)
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
                
                // Recipe Title
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Recipe Owner
                if let user = recipe.user {
                    HStack {
                        if let url = URL(string: user.profileImageURL ?? "") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(user.username)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Recipe Description
                Text(recipe.description)
                    .font(.body)
                    .padding(.horizontal)
                
                // Recipe Ingredients
                Text("Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient.name)
                        .padding(.horizontal)
                }
                
                // Recipe Instructions
                Text("Instructions")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.instructions[index].description)")
                        .padding(.horizontal)
                }
                
                // Recipe Details
                HStack {
                    Text("Cook Time: \(recipe.cookTime) minutes")
                    Spacer()
                    Text("Servings: \(recipe.servings)")
                }
                .padding(.horizontal)
                
                // Recipe Likes
                HStack {
                    Text("Likes: \(recipe.likes)")
                    Spacer()
                    Text("Cuisine Type: \(recipe.type)")
                }
                .padding(.horizontal)
                
                // Nutritional Values
                if let nutritionalValues = recipe.nutritionalValues {
                    Text("Nutritional Values")
                        .font(.headline)
                        .padding(.horizontal)
                    Text("Calories: \(nutritionalValues.calories)")
                        .padding(.horizontal)
                    Text("Protein: \(nutritionalValues.protein)g")
                        .padding(.horizontal)
                    Text("Fat: \(nutritionalValues.fat)g")
                        .padding(.horizontal)
                    Text("Carbohydrates: \(nutritionalValues.carbohydrates)g")
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Recipe Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RecipeEditorView(isNewRecipe: false, recipe: Binding(get: { Optional(recipe) }, set: { recipe = $0! }))) {
                    Text("Edit")
                }
            }
        }
    }
}

#Preview {
    RecipeView(recipe: MockData.shared.recipe[0])
}
