//
//  Recipe.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: String
    
    var title: String
    var imageURL: String
    var ownerId: String
    
    var createdAt: Date
    var updatedAt: Date
    
    var description: String
    var ingredients: [Ingredient]
    var instructions: [Instruction]
    var cookTime: Int
    var servings: Int
    
    var likes: Int
    var type: String
    var nutritionalValues: NutritionalValues?
    var user: User?
    
    var peopleWhoLiked: [String]?
    var reviews: [Review]?
    
    init(
        id: String,
        
        title: String,
        imageURL: String,
        ownerId: String,
        
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        
        description: String,
        ingredients: [Ingredient],
        instructions: [Instruction],
        cookTime: Int,
        servings: Int,
        
        likes: Int,
        type: String,
        nutritionalValues: NutritionalValues?,
        
        user: User? = nil,
        
        peopleWhoLiked: [String]? = nil,
        reviews: [Review]? = nil
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
        self.type = type
        self.nutritionalValues = nutritionalValues
        self.user = user
        
        self.peopleWhoLiked = peopleWhoLiked
        self.reviews = reviews
    }
    
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
        
        case peopleWhoLiked
        case reviews
    }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            
            self.title = try container.decode(String.self, forKey: .title)
            self.imageURL = try container.decode(String.self, forKey: .imageURL)
            self.ownerId = try container.decode(String.self, forKey: .ownerId)
            
            self.createdAt = try container.decode(Date.self, forKey: .createdAt)
            self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
            
            self.description = try container.decode(String.self, forKey: .description)
            self.ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
            self.instructions = try container.decode([Instruction].self, forKey: .instructions)
            self.cookTime = try container.decode(Int.self, forKey: .cookTime)
            self.servings = try container.decode(Int.self, forKey: .servings)
            
            self.likes = try container.decode(Int.self, forKey: .likes)
            self.type = try container.decode(String.self, forKey: .type)
            self.nutritionalValues = try container.decodeIfPresent(NutritionalValues.self, forKey: .nutritionalValues)
            self.user = try container.decodeIfPresent(User.self, forKey: .user)
            
            self.peopleWhoLiked = try container.decodeIfPresent([String].self, forKey: .peopleWhoLiked)
            self.reviews = try container.decodeIfPresent([Review].self, forKey: .reviews)
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            
            try container.encode(title, forKey: .title)
            try container.encode(imageURL, forKey: .imageURL)
            try container.encode(ownerId, forKey: .ownerId)
            
            try container.encode(createdAt, forKey: .createdAt)
            try container.encode(updatedAt, forKey: .updatedAt)
            
            try container.encode(description, forKey: .description)
            try container.encode(ingredients, forKey: .ingredients)
            try container.encode(instructions, forKey: .instructions)
            try container.encode(cookTime, forKey: .cookTime)
            try container.encode(servings, forKey: .servings)
            
            try container.encode(likes, forKey: .likes)
            try container.encode(type, forKey: .type)
            try container.encodeIfPresent(nutritionalValues, forKey: .nutritionalValues)
            try container.encodeIfPresent(user, forKey: .user)
            
            try container.encodeIfPresent(peopleWhoLiked, forKey: .peopleWhoLiked)
            try container.encodeIfPresent(reviews, forKey: .reviews)
    }
}
