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
    
    var recipes: [Recipe]
    var followers: [User]
    var following: [User]
    
    var createdAt: Date?
    var updatedAt: Date?
    
    var profileImageURL: String?
    var bio: String?
    
    init(
        id: String,
         email: String,
         username: String,
        
         firstName: String,
         lastName: String,
        
         phone: String,
         dateOfBirth: Date,
        
         recipes: [Recipe] = [],
         followers: [User] = [],
         following: [User] = [],
        
         createdAt: Date? = Date(),
         updatedAt: Date? = Date(),
        
         profileImageURL: String? = nil,
         bio: String = "Hi! I'm new to FlavorShare!")
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
        case profileImageURL
        case bio
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
            self.recipes = try container.decode([Recipe].self, forKey: .recipes)
        } catch {
            print("Failed to decode recipes: \(error)")
            self.recipes = []
        }
        
        do {
            self.followers = try container.decode([User].self, forKey: .followers)
        } catch {
            print("Failed to decode followers: \(error)")
            self.followers = []
        }
        
        do {
            self.following = try container.decode([User].self, forKey: .following)
        } catch {
            print("Failed to decode following: \(error)")
            self.following = []
        }
        self.profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
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
        try container.encodeIfPresent(profileImageURL, forKey: .profileImageURL)
        try container.encodeIfPresent(bio, forKey: .bio)
    }
}
