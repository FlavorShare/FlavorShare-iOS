//
//  RecipeAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeAPIService {
    static let shared = RecipeAPIService()
    
    // MARK: - fetchCuisineTypes()
    /**
     Get a String array containing the different recipe category
     - returns: String array with the cuisineType server enum OR the error encoutered
     */
    func fetchCuisineTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/cuisinetypes", completion: completion)
    }
    
    // MARK: - fetchAllRecipes()
    /**
     Get a list of all recipe created
     - returns: Recipe array of all recipe  OR the error encoutered
     */
    func fetchAllRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/recipes", completion: completion)
    }
    
    // MARK: - fetchRecipeById()
    /**
     Get a specified recipe based on it's ID
     - parameter id: The recipe ID for the recipe you want back
     - returns: The Recipe found  OR the error encoutered
     */
    func fetchRecipeById(id: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/recipes/\(id)", completion: completion)
    }
    
    // MARK: - createRecipe()
    /**
     Post new recipe to the server
     - parameter recipe: The new recipe to add to the database
     - returns: The created recipe OR the encoutered error
     */
    func createRecipe(recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            AppAPIHandler.shared.performRequest(endpoint: "/recipes", method: "POST", body: data, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - updateRecipe()
    /**
     Update the existing recipe with the edited data
     - parameter id: The ID for the edited recipe
     - parameter recipe: The new recipe to update to the database
     - returns: The edited recipe OR the encoutered error
     */
    func updateRecipe(id: String, recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            AppAPIHandler.shared.performRequest(endpoint: "/recipes/\(id)", method: "PUT", body: data, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - deleteRecipe()
    /**
     Delete an existing recipe
     - parameter id: The ID for the recipe to delete
     - returns: Nothing OR the encoutered error
     */
    func deleteRecipe(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/recipes/\(id)", method: "DELETE") { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
