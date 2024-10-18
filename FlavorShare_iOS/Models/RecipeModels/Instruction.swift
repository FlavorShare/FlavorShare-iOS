//
//  Instruction.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Instruction: Identifiable, Hashable, Codable {
    let id = UUID()
    
    
    var step: Int
    var description: String
    var ingredients: [String]?
    
    init(step: Int, description: String, ingredients: [String]? = nil) {
        self.step = step
        self.description = description
        self.ingredients = ingredients
    }
    
    enum CodingKeys: String, CodingKey {
        case step
        case description
        case ingredients
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.step = try container.decode(Int.self, forKey: .step)
        self.description = try container.decode(String.self, forKey: .description)
        self.ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(step, forKey: .step)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(ingredients, forKey: .ingredients)
    }
    
}
