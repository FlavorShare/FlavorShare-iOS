//
//  Review.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-27.
//

import Foundation

struct Review: Identifiable, Hashable, Codable {
    let id = UUID()
    
    var ownerId: String
    var rating: Int
    var comment: String
    var createdAt: Date
    var updatedAt: Date
    
    init(ownerId: String, rating: Int, comment: String, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.ownerId = ownerId
        self.rating = rating
        self.comment = comment
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case ownerId
        case rating
        case comment
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ownerId = try container.decode(String.self, forKey: .ownerId)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ownerId, forKey: .ownerId)
        try container.encode(rating, forKey: .rating)
        try container.encode(comment, forKey: .comment)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
