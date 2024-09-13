//
//  RecipeAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeAPIService {
    static let shared = RecipeAPIService()
    private let baseURL = "http://localhost:3000" // Adjust the base URL as necessary
    
    struct Recipe: Identifiable, Codable {
        let id: String
        let title: String
        let imageURL: String
        let ownerId: String
        let createdAt: Date
        let updatedAt: Date
        let description: String
        let ingredients: [Ingredient]
        let instructions: [Instruction]
        let cookTime: Int
        let servings: Int
        let likes: Int
        let type: String
        let nutritionalValues: NutritionalValues?
        let user: User?
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case title
            case imageURL
            case ownerId
            case createdAt
            case updatedAt
            case description
            case ingredients
            case instructions
            case cookTime
            case servings
            case likes
            case type
            case nutritionalValues
            case user
        }
    }
    
    struct Ingredient: Codable {
        var name: String
        var quantity: String
        var imageURL: String?
    }
    
    struct Instruction: Codable {
        var step: Int
        var description: String
    }
    
    struct NutritionalValues: Codable {
        let calories: Int
        let protein: Int
        let fat: Int
        let carbohydrates: Int
    }
    
    struct User: Codable {
        let id: String
        let email: String
        let username: String
        let firstName: String
        let lastName: String
        let phone: String
        let dateOfBirth: Date
        let profileImageURL: String?
        let bio: String?
        let isFollowed: Bool?
        let stats: UserStats?
        let isCurrentUser: Bool
    }
    
    struct UserStats: Codable {
        let followers: Int
        let following: Int
        let posts: Int
    }
    
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
    
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
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
