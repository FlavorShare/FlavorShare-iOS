//
//  FoodItem.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-04.
//

import Foundation

struct FoodItem: Identifiable, Hashable, Codable {
    let id = UUID()

    var _id: String

    var name: String
    var category: String
    
    var quantity: Float?
    var unit: String?
    
    var allergens: [String]?
    var imageURL: String?
    
    var isCompleted: Bool? = false
    
    init(name: String, category: String, allergens: [String]? = nil, imageURL: String? = nil, quantity: Float? = nil, unit: String? = nil) {
        self._id = UUID().uuidString

        self.name = name
        self.category = category
        self.allergens = allergens
        self.imageURL = imageURL
        
        self.quantity = quantity
        self.unit = unit
    }
    
    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case category
        
        case quantity
        case unit
        
        case allergens
        case imageURL
        
        case isCompleted
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        
        self.quantity = try container.decodeIfPresent(Float.self, forKey: .quantity)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        
        self.allergens = try container.decodeIfPresent([String].self, forKey: .allergens)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        
        self.isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(name, forKey: .name)
        
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(unit, forKey: .unit)
        
        try container.encode(category, forKey: .category)
        try container.encodeIfPresent(allergens, forKey: .allergens)
        try container.encodeIfPresent(imageURL, forKey: .imageURL)
        
        try container.encodeIfPresent(isCompleted, forKey: .isCompleted)
    }
}
