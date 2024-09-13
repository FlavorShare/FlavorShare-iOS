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
            type: type, // Convert to String
            nutritionalValues: nutritionalValues,
            user: user
        )

        guard let url = URL(string: "http://localhost:3000/recipes") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(newRecipe)
            request.httpBody = jsonData
            print("Request Payload: \(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")")
        } catch {
            self.errorMessage = "Failed to encode recipe"
            self.isLoading = false
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    print("Response Status Code: \(httpResponse.statusCode)")
                }

                if let data = data {
                    print("Response Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    self.errorMessage = "Failed to create recipe"
                    completion(false)
                    return
                }

                self.isSuccess = true
                completion(true)
            }
        }.resume()
    }

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
            type: type, // Convert to String
            nutritionalValues: nutritionalValues,
            user: user
        )
        
        func deleteRecipe(completion: @escaping (Bool) -> Void) {
                isLoading = true

                guard let url = URL(string: "http://localhost:3000/recipes/\(id)") else {
                    self.errorMessage = "Invalid URL"
                    self.isLoading = false
                    completion(false)
                    return
                }

                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"

                URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        self.isLoading = false
                        if let error = error {
                            self.errorMessage = error.localizedDescription
                            completion(false)
                            return
                        }

                        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                            self.errorMessage = "Failed to delete recipe"
                            completion(false)
                            return
                        }

                        self.isSuccess = true
                        completion(true)
                    }
                }.resume()
            }

        guard let url = URL(string: "http://localhost:3000/recipes/\(id)") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(updatedRecipe)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode recipe"
            self.isLoading = false
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Failed to update recipe"
                    completion(false)
                    return
                }

                self.isSuccess = true
                completion(true)
            }
        }.resume()
    }
}
