//
//  RecipeCreationView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeEditorView: View {
    @State private var title: String
    @State private var cuisineType: String
    @State private var ingredients: [String]
    @State private var instructions: [String]
    @State private var prepTime: Int
    @State private var cookTime: Int
    @State private var servings: Int
    private var isEditing: Bool
    
    // Initialize with an existing recipe or a new one
    init(recipe: Recipe? = nil) {
        _title = State(initialValue: recipe?.title ?? "")
        _cuisineType = State(initialValue: recipe?.cuisineType ?? "")
        _ingredients = State(initialValue: recipe?.ingredients ?? [])
        _instructions = State(initialValue: recipe?.instructions ?? [])
        _prepTime = State(initialValue: recipe?.prepTime ?? 0)
        _cookTime = State(initialValue: recipe?.cookTime ?? 0)
        _servings = State(initialValue: recipe?.servings ?? 1)
        isEditing = recipe != nil
    }
    
    var body: some View {
        Form {
            Section(header: Text("Recipe Information")) {
                TextField("Title", text: $title)
                
                TextField("Cuisine Type", text: $cuisineType)
            }
            
            Section(header: Text("Ingredients")) {
                ForEach(0..<ingredients.count, id: \.self) { index in
                    TextField("Ingredient", text: $ingredients[index])
                }
                Button(action: {
                    ingredients.append("")
                }) {
                    Label("Add Ingredient", systemImage: "plus.circle")
                }
            }
            
            Section(header: Text("Instructions")) {
                ForEach(0..<instructions.count, id: \.self) { index in
                    TextEditor(text: $instructions[index])
                        .frame(height: 100)
                }
                Button(action: {
                    instructions.append("")
                }) {
                    Label("Add Instruction", systemImage: "plus.circle")
                }
            }
            
            Section(header: Text("Times & Servings")) {
                Stepper(value: $prepTime, in: 0...180, step: 5) {
                    Text("Prep Time: \(prepTime) minutes")
                }
                
                Stepper(value: $cookTime, in: 0...180, step: 5) {
                    Text("Cook Time: \(cookTime) minutes")
                }
                
                Stepper(value: $servings, in: 1...20) {
                    Text("Servings: \(servings)")
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Recipe" : "New Recipe")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Update" : "Add") {
                    saveRecipe()
                }
            }
        }
    }
    
    // Function to save the recipe (implement your save logic here)
    private func saveRecipe() {
        let newRecipe = Recipe(
            title: title,
            cuisineType: cuisineType,
            ingredients: ingredients,
            instructions: instructions,
            prepTime: prepTime,
            cookTime: cookTime,
            servings: servings,
            createdAt: Date(),
            updatedAt: Date()
        )
        // Add logic to save the newRecipe (e.g., update your database or state)
        print("Recipe saved: \(newRecipe)")
    }
}

#Preview {
    NavigationView {
        RecipeEditorView(recipe: Recipe(
            title: "Sample Recipe",
            cuisineType: "Fusion",
            ingredients: ["Ingredient 1", "Ingredient 2"],
            instructions: ["Instruction 1", "Instruction 2"],
            prepTime: 15,
            cookTime: 30,
            servings: 4,
            createdAt: Date(),
            updatedAt: Date()
        ))
    }
}
