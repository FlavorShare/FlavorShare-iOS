//
//  Ingredient.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Ingredient: Identifiable, Hashable, Codable {
    let id = UUID()
    var name: String
    var quantity: Int?
    var unit: String?
    var imageURL: String?
    
    init(name: String, quantity: Int? = nil, unit: String? = nil, imageURL: String? = nil) {
        self.name = name
        
//        if quantity == nil {
//            self.quantity = 1
//        } else {
            self.quantity = quantity
//        }
        
        self.unit = unit
        self.imageURL = imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
        case unit
        case imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(imageURL, forKey: .imageURL)
    }
}
