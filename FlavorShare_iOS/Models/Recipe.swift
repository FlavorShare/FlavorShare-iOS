//
//  Recipe.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import Foundation

struct Recipe {
    let title: String
    let cuisineType: String
    let ingredients: [String]
    let instructions: [String]
    let prepTime: Int // in minutes
    let cookTime: Int // in minutes
    let servings: Int
    let createdAt: Date?
    let updatedAt: Date?
    
    // A default initializer in case you want to set default values like in the TypeScript model
    init(
        title: String,
        cuisineType: String,
        ingredients: [String],
        instructions: [String],
        prepTime: Int,
        cookTime: Int,
        servings: Int,
        createdAt: Date? = Date(),
        updatedAt: Date? = Date()
    ) {
        self.title = title
        self.cuisineType = cuisineType
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
