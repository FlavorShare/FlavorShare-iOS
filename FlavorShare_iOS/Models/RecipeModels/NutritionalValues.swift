//
//  NutritionalValues.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct NutritionalValues: Codable {
    var calories: Int
    var protein: Int
    var fat: Int
    var carbohydrates: Int
    
    init(calories: Int, protein: Int, fat: Int, carbohydrates: Int) {
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
    }
    
    enum CodingKeys: String, CodingKey {
        case calories
        case protein
        case fat
        case carbohydrates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.calories = try container.decode(Int.self, forKey: .calories)
        self.protein = try container.decode(Int.self, forKey: .protein)
        self.fat = try container.decode(Int.self, forKey: .fat)
        self.carbohydrates = try container.decode(Int.self, forKey: .carbohydrates)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(calories, forKey: .calories)
        try container.encode(protein, forKey: .protein)
        try container.encode(fat, forKey: .fat)
        try container.encode(carbohydrates, forKey: .carbohydrates)
    }
}
