//
//  User.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var email: String
    var username: String
    
    var firstName: String
    var lastName: String
    
    var phone: String
    var dateOfBirth: Date
    
    var recipes: [String]
    var followers: [String]
    var following: [String]
    
    var createdAt: Date?
    var updatedAt: Date?
    
    var profileImageURL: String?
    var bio: String?
    
    var likedRecipes: [String]?
    
    init(
        id: String,
        email: String,
        username: String,
        
        firstName: String,
        lastName: String,
        
        phone: String,
        dateOfBirth: Date,
        
        recipes: [String] = [],
        followers: [String] = [],
        following: [String] = [],
        
        createdAt: Date? = Date(),
        updatedAt: Date? = Date(),
        
        profileImageURL: String? = nil,
        bio: String = "Hi! I'm new to FlavorShare!",
    
        likedRecipes: [String]? = []
    )
    {
        self.id = id
        self.email = email
        self.username = username
        
        self.firstName = firstName
        self.lastName = lastName
        
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        
        self.recipes = recipes
        self.followers = followers
        self.following = following
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.profileImageURL = profileImageURL
        self.bio = bio
        
        self.likedRecipes = likedRecipes
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case username
        
        case firstName
        case lastName
        
        case phone
        case dateOfBirth
        
        case recipes
        case followers
        case following
        
        case createdAt
        case updatedAt
        
        case profileImageURL
        case bio
        
        case likedRecipes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.username = try container.decode(String.self, forKey: .username)
        
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        
        self.phone = try container.decode(String.self, forKey: .phone)
        self.dateOfBirth = try container.decode(Date.self, forKey: .dateOfBirth)
        
        do {
            self.recipes = try container.decode([String].self, forKey: .recipes)
        } catch let error {
            print("Failed to decode recipes: \(error.localizedDescription)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type Mismatch: \(type), Context: \(context)")
                case .valueNotFound(let type, let context):
                    print("Value Not Found: \(type), Context: \(context)")
                case .keyNotFound(let key, let context):
                    print("Key Not Found: \(key), Context: \(context)")
                case .dataCorrupted(let context):
                    print("Data Corrupted: \(context)")
                @unknown default:
                    print("Unknown Decoding Error")
                }
            }
            self.recipes = []
        }
        
        do {
            self.followers = try container.decode([String].self, forKey: .followers)
        } catch {
            print("Failed to decode followers: \(error)")
            self.followers = []
        }
        
        do {
            self.following = try container.decode([String].self, forKey: .following)
        } catch {
            print("Failed to decode following: \(error)")
            self.following = []
        }
        
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)

        self.profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        
        self.likedRecipes = try container.decodeIfPresent([String].self, forKey: .likedRecipes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(username, forKey: .username)
        
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        
        try container.encode(phone, forKey: .phone)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        
        try container.encode(recipes, forKey: .recipes)
        try container.encode(followers, forKey: .followers)
        try container.encode(following, forKey: .following)
        
        // Created and Updated at are handled in the backend
        try container.encodeIfPresent(profileImageURL, forKey: .profileImageURL)
        try container.encodeIfPresent(bio, forKey: .bio)
            
        try container.encodeIfPresent(likedRecipes, forKey: .likedRecipes)
    }
}
