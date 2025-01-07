//
//  RecipeFunctions.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import Foundation

class RecipeFunctions {
    static func getInstructionIngredients(recipe: Recipe, instruction: Instruction) -> [Ingredient] {
        if let listIngredientID = instruction.ingredients {
            return listIngredientID.compactMap { ingredientID in
                return recipe.ingredients.first { $0._id == ingredientID }
            }
        }
        
        return []
    }
    
    static func getQuantity(recipe: Recipe, selectedServings: Int, quantity: Float) -> Float {
        return quantity * Float(Float(selectedServings) / Float(recipe.servings))
        
    }
}
