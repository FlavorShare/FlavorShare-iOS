//
//  RecipeListView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeListView: View {
    let recipes: [Recipe]
    
    var body: some View {
        NavigationView {
            List(recipes, id: \.title) { recipe in
                NavigationLink(destination: RecipeView(recipe: recipe)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.headline)
                            Text(recipe.cuisineType)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(recipe.servings) servings")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView(recipes: [
        Recipe(
            title: "Spaghetti Bolognese",
            cuisineType: "Italian",
            ingredients: ["Spaghetti", "Tomato Sauce", "Ground Beef"],
            instructions: ["Cook spaghetti", "Prepare the sauce", "Combine and serve"],
            prepTime: 10,
            cookTime: 20,
            servings: 4,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Recipe(
            title: "Vegetable Stir Fry",
            cuisineType: "Chinese",
            ingredients: ["Broccoli", "Carrots", "Bell Peppers", "Soy Sauce"],
            instructions: ["Chop vegetables", "Stir fry in pan", "Add soy sauce and serve"],
            prepTime: 15,
            cookTime: 10,
            servings: 3,
            createdAt: Date(),
            updatedAt: Date()
        )
    ])
}
