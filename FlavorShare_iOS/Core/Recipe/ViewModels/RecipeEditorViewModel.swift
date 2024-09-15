//
//  RecipeEditorViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeEditorViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var title: String = ""
    @Published var imageURL: String = ""
    @Published var ownerId: String = ""
    @Published var createdAt: Date = Date()
    @Published var updatedAt: Date = Date()
    @Published var description: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var instructions: [Instruction] = []
    @Published var cookTime: Int = 0
    @Published var servings: Int = 0
    @Published var likes: Int = 0
    @Published var type: String = "Italian" // Default value
    @Published var nutritionalValues: NutritionalValues?
    @Published var user: User?
    @Published var cuisineTypes: [String] = []
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    init() {
        fetchCuisineTypes()
    }
    
    // MARK: Load Existing Recipe
    /**
     Update the recipe properties with an existing recipe values
     - Authors: Benjamin Lefebvre
     */
    func loadRecipe(_ recipe: Recipe) {
        self.id = recipe.id
        self.title = recipe.title
        self.imageURL = recipe.imageURL
        self.ownerId = recipe.ownerId
        self.createdAt = recipe.createdAt
        self.updatedAt = recipe.updatedAt
        self.description = recipe.description
        self.ingredients = recipe.ingredients
        self.instructions = recipe.instructions
        self.cookTime = recipe.cookTime
        self.servings = recipe.servings
        self.likes = recipe.likes
        self.type = recipe.type
        self.nutritionalValues = recipe.nutritionalValues
        self.user = recipe.user
    }
    
    // MARK: Load Cuisine Types
    /**
     Update the cuisineTypes property with the API enum values
     - Authors: Benjamin Lefebvre
     */
    func fetchCuisineTypes() {
        RecipeAPIService.shared.fetchCuisineTypes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let types):
                    self.cuisineTypes = types
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: Add Recipe
    /**
     Send the newRecipe object to the RecipeAPIService to add it to the database
     - Authors: Benjamin Lefebvre
     */
    func createRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let newRecipe = Recipe(
            id: UUID().uuidString,
            title: title,
            imageURL: imageURL,
            ownerId: ownerId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: description,
            ingredients: ingredients,
            instructions: instructions,
            cookTime: cookTime,
            servings: servings,
            likes: likes,
            type: type,
            nutritionalValues: nutritionalValues,
            user: user
        )
        
        RecipeAPIService.shared.createRecipe(recipe: newRecipe) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let recipe):
                    self.loadRecipe(recipe)
                    self.isSuccess = true
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    // MARK: Update Recipe
    /**
     Send the updatedRecipe object to the RecipeAPIService to update the existing object on the database
     - Authors: Benjamin Lefebvre
     */
    func updateRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
        let updatedRecipe = Recipe(
            id: id,
            title: title,
            imageURL: imageURL,
            ownerId: ownerId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: description,
            ingredients: ingredients,
            instructions: instructions,
            cookTime: cookTime,
            servings: servings,
            likes: likes,
            type: type,
            nutritionalValues: nutritionalValues,
            user: user
        )
        
        RecipeAPIService.shared.updateRecipe(id: id, recipe: updatedRecipe) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let recipe):
                    self.loadRecipe(recipe)
                    self.isSuccess = true
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    // MARK: Delete Recipe
    /**
     Send the deletion request to the RecipeAPIService for tthe currently displayed recipe
     - Authors: Benjamin Lefebvre
     */
    func deleteRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        RecipeAPIService.shared.deleteRecipe(id: id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.isSuccess = true
                    completion(true)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
