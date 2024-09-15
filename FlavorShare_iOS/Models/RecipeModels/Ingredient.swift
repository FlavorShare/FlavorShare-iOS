//
//  Ingredient.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Ingredient: Hashable, Codable {
    var name: String
    var quantity: Int?
    var imageURL: String?
    
    init(name: String, quantity: Int? = nil, imageURL: String? = nil) {
        self.name = name
        
        if quantity == nil {
            self.quantity = 1
        } else {
            self.quantity = quantity
        }
        
        self.imageURL = imageURL
    }
}
