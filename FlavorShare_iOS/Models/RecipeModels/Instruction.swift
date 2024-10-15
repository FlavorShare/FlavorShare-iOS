//
//  Instruction.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Instruction: Hashable, Codable {
    var step: Int
    var description: String
    var ingredients: [Ingredient]?
    
    init(step: Int, description: String, ingredients: [Ingredient]? = []) {
        self.step = step
        self.description = description
        self.ingredients = ingredients
    }
}
