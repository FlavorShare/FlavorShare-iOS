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
    
    var createdAt: Date?
    var updatedAt: Date?
    
    var profileImageURL: String?
    var bio: String?
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool?
    
    init(id: String, 
         email: String,
         username: String,
         firstName: String,
         lastName: String,
         phone: String,
         dateOfBirth: Date,
         createdAt: Date? = Date(),
         updatedAt: Date? = Date(),
         profileImageURL: String? = nil,
         bio: String? = nil,
         isFollowed: Bool? = nil,
         stats: UserStats? = nil,
         isCurrentUser: Bool? = nil) {
        self.id = id
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.profileImageURL = profileImageURL
        self.bio = bio
        self.isFollowed = isFollowed
        self.stats = stats
        self.isCurrentUser = isCurrentUser
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case username
        case firstName
        case lastName
        case phone
        case dateOfBirth
        case profileImageURL
        case bio
        case isFollowed
        case stats
        case isCurrentUser
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
        self.profileImageURL = try container.decodeIfPresent(String.self, forKey: .profileImageURL)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.isFollowed = try container.decodeIfPresent(Bool.self, forKey: .isFollowed)
        self.stats = try container.decodeIfPresent(UserStats.self, forKey: .stats)
        self.isCurrentUser = try container.decodeIfPresent(Bool.self, forKey: .isCurrentUser)
    }
}

struct UserStats: Codable {
    var followers: Int
    var following: Int
    var posts: Int
    
    init(followers: Int, following: Int, posts: Int) {
        self.followers = followers
        self.following = following
        self.posts = posts
    }
}
