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
        print("Fetching all recipes")
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
    
    // MARK: fetchRecipes(for user: User)
    /**
     Get the recipes for a specific user
     - parameter user: The user to get the recipes for
     - returns: Recipe array of all the user's recipes OR the error encoutered
     */
    func fetchRecipes(for user: User, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        print("Fetching recipes for user")
        AppAPIHandler.shared.performRequest(endpoint: "/recipes/user/\(user.id)", completion: completion)
    }
    
    // MARK: - fetchRecipesByIds()
    /**
     Get a list of recipes based on their IDs
     - parameter ids: The recipe IDs for the recipes you want back
     - returns: Recipe array of all the recipes found OR the error encoutered
     */
    func fetchRecipesByIds(withIds ids: [String], completion: @escaping (Result<[Recipe], Error>) -> Void) {
        print("Fetching recipes by IDs")
        AppAPIHandler.shared.performRequest(endpoint: "/recipes/ids", method: "POST", body: try! JSONEncoder().encode(ids), completion: completion)
    }
    
    // MARK: - createRecipe()
    /**
     Post new recipe to the server
     - parameter recipe: The new recipe to add to the database
     - returns: The created recipe OR the encoutered error
     */
    func createRecipe(recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        do {
            print("Creating recipe")
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            AppAPIHandler.shared.performRequest(endpoint: "/recipes", method: "POST", body: data, completion: completion)
        } catch {
            print(error.localizedDescription)
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
            print("Updating recipe")
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            AppAPIHandler.shared.performRequest(endpoint: "/recipes/\(id)", method: "PUT", body: data, completion: completion)
            print("Update completed")
        } catch {
            print(error.localizedDescription)
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
