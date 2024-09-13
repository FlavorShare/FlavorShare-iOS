//
//  User.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct User: Encodable {
    let id: String
    var email: String
    var username: String
    
    var firstName: String
    var lastName: String
    
    var phone: String
    var dateOfBirth: Date
    
    var profileImageURL: String?
    var bio: String?
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool
    
    init(id: String, email: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date, profileImageURL: String? = nil, bio: String? = nil, isFollowed: Bool? = nil, stats: UserStats? = nil, isCurrentUser: Bool) {
        self.id = id
        self.email = email
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.profileImageURL = profileImageURL
        self.bio = bio
        self.isFollowed = isFollowed
        self.stats = stats
        self.isCurrentUser = isCurrentUser
    }
}

struct UserStats: Encodable {
    var followers: Int
    var following: Int
    var posts: Int
    
    init(followers: Int, following: Int, posts: Int) {
        self.followers = followers
        self.following = following
        self.posts = posts
    }
}
