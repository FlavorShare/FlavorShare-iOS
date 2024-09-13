//
//  Recipe.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import Foundation

struct Recipe: Identifiable {
    let id: String
    
    var title: String
    var imageURL: String
    var ownerId: String
    
    var createdAt: Date
    var updatedAt: Date
    
    var description: String
    var ingredients: [String]
    var instructions: [String]
    var cookTime: Int
    var servings: Int

    var likes: Int
    var cuisineType: String
    var nutrionalValues: NutritionalValues?
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
