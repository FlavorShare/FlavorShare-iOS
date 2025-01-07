//
//  RecipeEditorViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation
import SwiftUI

class RecipeEditorViewModel: ObservableObject {
    // MARK: Properties
    // ***** RECIPE PROPERTIES *****
    @Published var id: String = UUID().uuidString
    
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
    @Published var type: String = "Italian"
    @Published var nutritionalValues: NutritionalValues?
    @Published var user: User?
    
    // ****** OTHER PROPERTIES ******
    @Published var cuisineTypes: [String] = []
    @Published var units: [String] = ["", "g", "kg", "ml", "l", "tsp", "tbsp", "cup", "oz", "lb", "unit"]
    
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    @Published var selectedImage: UIImage?
    @Published var isImagePickerPresented: Bool = false
    
    @Published var foodItems: [FoodItem] = []
    @Published var filteredFoodItems: [FoodItem] = []
    
    init() {
        fetchCuisineTypes()
        assignOwnerID()
        getFoodItems()
    }
    
    // MARK: assignOwnerID()
    /**
     Assign the current user's ID to the ownerId property
     */
    func assignOwnerID() {
        self.ownerId = AuthService.shared.currentUser?.id ?? ""
    }
    
    // MARK: loadRecipe()
    /**
     Update the recipe properties with an existing recipe values
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
    
    // MARK: fetchCuisineTypes()
    /**
     Update the cuisineTypes property with the API enum values
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
    
    // MARK: getFoodItems()
    /**
     Update the foodItems property with the locally saved JSON data in Ressources
     */
    func getFoodItems() {
        foodItems = FoodItemsList.shared.foodItems
        
    }
    
    // MARK: searchFoodItems()
    /**
     Search the foodItems property for a given string
     */
    func searchFoodItems(for searchText: String) {
        print("Searching for: \(searchText)")
        
        // Filter the foodItems based on the search should also avoid returning duplicate based on name & category
        filteredFoodItems = foodItems.filter { foodItem in
            foodItem.name.lowercased().contains(searchText.lowercased()) || foodItem.category.lowercased().contains(searchText.lowercased())
        }
        
        // Filter out the foodItems that are already in the ingredients list
        filteredFoodItems = filteredFoodItems.filter { foodItem in
            !ingredients.contains(where: { $0.name == foodItem.name })
        }
        
        print("Fetched items: \(self.filteredFoodItems)")
    }
    
    // MARK: createRecipe()
    /**
     Send the newRecipe object to the RecipeAPIService to add it to the database
     */
    func createRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        // 1 - Confirm UIImage Picked
        guard let selectedImage = selectedImage else {
            self.errorMessage = "Please select an image."
            self.isLoading = false
            completion(false)
            return
        }
        
        // 2 - Convert Image
        guard let heifData = ImageConverter.shared.convertUIImageToHEIF(image: selectedImage) else {
            self.errorMessage = "Failed to convert image to HEIF."
            self.isLoading = false
            completion(false)
            return
        }
        
        let fileName = UUID().uuidString + ".heif"
        
        // 3 - Upload Image
        ImageStorageService.shared.uploadImage(data: heifData, fileName: fileName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.cleanInstructionsIngredients()
                    
                    // 4 - Save Recipe
                    let newRecipe = Recipe(
                        id: UUID().uuidString,
                        title: self.title,
                        imageURL: fileName,
                        ownerId: self.ownerId,
                        createdAt: self.createdAt,
                        updatedAt: self.updatedAt,
                        description: self.description,
                        ingredients: self.ingredients,
                        instructions: self.instructions,
                        cookTime: self.cookTime,
                        servings: self.servings,
                        likes: self.likes,
                        type: self.type,
                        nutritionalValues: self.nutritionalValues,
                        user: self.user
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
                    
                case .failure(let error):
                    // 4- Cancel Save Recipe
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    completion(false)
                }
            }
        }
    }
    
    // MARK: updateRecipe()
    /**
     Send the updatedRecipe object to the RecipeAPIService to update the existing object on the database
     */
    func updateRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
                
        if (imageURL == "" || selectedImage != nil) {
            guard let selectedImage = selectedImage else {
                self.errorMessage = "Please select an image."
                self.isLoading = false
                completion(false)
                return
            }
            
            guard let heifData = ImageConverter.shared.convertUIImageToHEIF(image: selectedImage) else {
                print("Failed to convert image to HEIF.")
                self.errorMessage = "Failed to convert image to HEIF."
                self.isLoading = false
                completion(false)
                return
            }
            
            ImageStorageService.shared.uploadImage(data: heifData, fileName: self.imageURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.isSuccess = true
                        completion(true)
                    case .failure(let error):
                        print("func updateRecipe(completion: @escaping (Bool) -> Void) - Error saving image: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                        completion(false)
                        return
                    }
                }
            }
        }
        
        cleanInstructionsIngredients()
        
        let updatedRecipe = Recipe(
            id: self.id,
            title: self.title,
            imageURL: self.imageURL,
            ownerId: self.ownerId,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            description: self.description,
            ingredients: self.ingredients,
            instructions: self.instructions,
            cookTime: self.cookTime,
            servings: self.servings,
            likes: self.likes,
            type: self.type,
            nutritionalValues: self.nutritionalValues,
            user: self.user
        )
        
        RecipeAPIService.shared.updateRecipe(id: self.id, recipe: updatedRecipe) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let recipe):
                    self.loadRecipe(recipe)
                    self.isSuccess = true
                    completion(true)
                case .failure(let error):
                    print("func updateRecipe(completion: @escaping (Bool) -> Void) - Error updating recipe: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    
    // MARK: deleteRecipe()
    /**
     Send the deletion request to the RecipeAPIService for tthe currently displayed recipe
     */
    func deleteRecipe(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        ImageStorageService.shared.deleteImage(fileName: imageURL) { result in
            switch result {
            case .success:
                RecipeAPIService.shared.deleteRecipe(id: self.id) { result in
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
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    completion(false)
                }
            }
        }
    }
    
    func cleanInstructionsIngredients() {
        // Iterate through the indices of each instruction
        for index in instructions.indices {
            // Filter the ingredients to only keep those that exist in the ingredients list
            instructions[index].ingredients = instructions[index].ingredients?.filter { ingredient in
                ingredients.contains(where: { $0._id == ingredient })
            }
        }
    }
}
