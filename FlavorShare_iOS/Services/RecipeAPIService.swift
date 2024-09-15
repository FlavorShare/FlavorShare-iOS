//
//  RecipeAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeAPIService {
    static let shared = RecipeAPIService()
    private let baseURL = "http://localhost:3000"
    
    // MARK: - fetchCuisineTypes()
    /**
     Get a String array containing the different recipe category
     - returns: String array with the cuisineType server enum OR the error encoutered
     */
    func fetchCuisineTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/cuisinetypes") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let cuisineTypes = try decoder.decode([String].self, from: data)
                completion(.success(cuisineTypes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - fetchAllRecipes()
    /**
     Get a list of all recipe created
     - returns: Recipe array of all recipe  OR the error encoutered
     */
    func fetchAllRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recipes") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                print("No Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let recipes = try decoder.decode([Recipe].self, from: data)
                completion(.success(recipes))
                print("SUCCESS!!")
            } catch {
                completion(.failure(error))
                print(error)
            }
        }.resume()
    }
    
    // MARK: - fetchRecipeById()
    /**
     Get a specified recipe based on it's ID
     - parameter id: The recipe ID for the recipe you want back
     - returns: The Recipe found  OR the error encoutered
     */
    func fetchRecipeById(id: String, completion: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recipes/\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let recipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(recipe))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - createRecipe()
    /**
     Post new recipe to the server
     - parameter recipe: The new recipe to add to the database
     - returns: The created recipe OR the encoutered error
     */
    func createRecipe(recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recipes") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            request.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let createdRecipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(createdRecipe))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - updateRecipe()
    /**
     Update the existing recipe with the edited data
     - parameter id: The ID for the edited recipe
     - parameter recipe: The new recipe to add to the database
     - returns: The edited recipe OR the encoutered error
     */
    func updateRecipe(id: String, recipe: Recipe, completion: @escaping (Result<Recipe, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recipes/\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(recipe)
            request.httpBody = data
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let updatedRecipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(updatedRecipe))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - deleteRecipe()
    /**
     Delete an existing recipe
     - parameter id: The ID for the recipe to delete
     - returns: Nothing OR the encoutered error
     */
    func deleteRecipe(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/recipes/\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
}
