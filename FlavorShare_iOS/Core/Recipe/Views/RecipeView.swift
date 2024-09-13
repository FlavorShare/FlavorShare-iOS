//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.largeTitle)
                .bold()
            
            Text("Cuisine: \(recipe.cuisineType)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Ingredients")
                .font(.headline)
            
            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text("- \(ingredient)")
            }
            
            Text("Instructions")
                .font(.headline)
            
            ForEach(recipe.instructions, id: \.self) { instruction in
                Text(instruction)
                    .padding(.bottom, 4)
            }
            
            HStack {
                Text("Prep Time: \(recipe.prepTime) mins")
                Spacer()
                Text("Cook Time: \(recipe.cookTime) mins")
            }
            .font(.subheadline)
            
            Text("Servings: \(recipe.servings)")
                .font(.subheadline)
            
            if let createdAt = recipe.createdAt {
                Text("Created at: \(formattedDate(createdAt))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            if let updatedAt = recipe.updatedAt {
                Text("Updated at: \(formattedDate(updatedAt))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
    
    // Helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    RecipeView(recipe: Recipe(
        title: "Spaghetti Bolognese",
        cuisineType: "Italian",
        ingredients: ["Spaghetti", "Tomato Sauce", "Ground Beef"],
        instructions: ["Cook spaghetti", "Prepare the sauce", "Combine and serve"],
        prepTime: 10,
        cookTime: 20,
        servings: 4,
        createdAt: Date(),
        updatedAt: Date()
    ))
}
