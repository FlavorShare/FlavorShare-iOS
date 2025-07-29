//
//  MealPlanItem.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-06.
//

import Foundation

struct MealPlanItem: Identifiable, Codable, Equatable {
    var id: String
    
    var recipe: Recipe
    var servings: Int
    
    init(recipe: Recipe, servings: Int) {
        self.id = UUID().uuidString
        
        self.recipe = recipe
        self.servings = servings
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case recipe
        case servings
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.recipe = try container.decode(Recipe.self, forKey: .recipe)
        self.servings = try container.decode(Int.self, forKey: .servings)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        
        try container.encode(recipe, forKey: .recipe)
        try container.encode(servings, forKey: .servings)
    }
    
    // Implement the Equatable protocol
    static func == (lhs: MealPlanItem, rhs: MealPlanItem) -> Bool {
        return lhs.id == rhs.id
    }
}
