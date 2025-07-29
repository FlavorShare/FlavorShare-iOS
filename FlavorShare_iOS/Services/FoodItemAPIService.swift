//
//  FoodItemAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-04.
//

import Foundation

class FoodItemAPIService {
    static let shared = FoodItemAPIService()
    
    // MARK: - fetchAllFoodItems()
    func fetchAllFoodItems(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/foodItems", completion: completion)
    }
    
    // MARK: - fetchFoodItemById()
    func fetchFoodItemById(id: String, completion: @escaping (Result<FoodItem, Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/foodItems/\(id)", completion: completion)
    }
    
    // MARK: - createFoodItem()
    func createFoodItem(foodItem: FoodItem, completion: @escaping (Result<FoodItem, Error>) -> Void) {
        let encoder = JSONEncoder()
        do {
            let body = try encoder.encode(foodItem)
            AppAPIHandler.shared.performRequest(endpoint: "/foodItems", method: "POST", body: body, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - createFoodItems()
    func createFoodItems(foodItems: [FoodItem], completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        let encoder = JSONEncoder()
        do {
            let body = try encoder.encode(foodItems)
            AppAPIHandler.shared.performRequest(endpoint: "/foodItems", method: "POST", body: body, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
