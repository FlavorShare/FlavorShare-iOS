//
//  Ingredient.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Ingredient: Identifiable, Hashable, Codable {
    let id = UUID()
    
    var _id: String
    
    var name: String
    var quantity: Float?
    var unit: String?
    var imageURL: String?
    var isCompleted: Bool? = false
    
    init(name: String, quantity: Float? = nil, unit: String? = "", imageURL: String? = nil) {
        self._id = UUID().uuidString
        
        self.name = name
        self.quantity = quantity
        self.unit = unit
        self.imageURL = imageURL
    }
    
    func getFormattedQuantity() -> String {
        guard let quantity = quantity else {
            return ""
        }
        return decimalToFraction(Double(quantity))
    }
    
    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case quantity
        case unit
        case imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: .name)
        self.quantity = try container.decodeIfPresent(Float.self, forKey: .quantity)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(unit, forKey: .unit)
        try container.encodeIfPresent(imageURL, forKey: .imageURL)
    }
}
