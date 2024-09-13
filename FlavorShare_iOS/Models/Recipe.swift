//
//  Recipe.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import Foundation

struct Recipe {
    let id: String
    
    let title: String
    let imageURL: String
    let ownerId: String
    
    let createdAt: Date
    let updatedAt: Date
    
    let description: String
    let ingredients: [String]
    let instructions: [String]
    let cookTime: Int 
    let servings: Int

    let likes: Int
    let cuisineType: String
    let nutrionalValues: NutritionalValues?
    var user: User?
    
    init(
        id: String,
        
        title: String,
        imageURL: String,
        ownerId: String,
        
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        
        description: String,
        ingredients: [String],
        instructions: [String],
        cookTime: Int,
        servings: Int,

        likes: Int,
        cuisineType: String,
        nutrionalValues: NutritionalValues?,
        user: User?
    ) {
        self.id = id
        
        self.title = title
        self.imageURL = imageURL
        self.ownerId = ownerId
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        self.cookTime = cookTime
        self.servings = servings
        
        self.likes = likes
        self.cuisineType = cuisineType
        self.nutrionalValues = nutrionalValues
        self.user = user
    }
}
