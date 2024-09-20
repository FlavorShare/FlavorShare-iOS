//
//  RecipeEditorViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation
import SwiftUI

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
    
    @Published var selectedImage: UIImage?
    @Published var isImagePickerPresented: Bool = false
    
    init() {
        fetchCuisineTypes()
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
        
        guard let selectedImage = selectedImage else {
            self.errorMessage = "Please select an image."
            self.isLoading = false
            completion(false)
            return
        }
        
        guard let heifData = ImageConverter.shared.convertUIImageToHEIF(image: selectedImage) else {
            self.errorMessage = "Failed to convert image to HEIF."
            self.isLoading = false
            completion(false)
            return
        }
                
        ImageStorageService.shared.uploadImage(data: heifData, fileName: self.imageURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
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
                                self.errorMessage = error.localizedDescription
                                completion(false)
                            }
                        }
                    }
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
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
}
