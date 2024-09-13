//
//  Ingredient.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Ingredient {
    var name: String
    var quantity: String
    var imageURL: String?
    
    init(name: String, quantity: String, imageURL: String?) {
        self.name = name
        self.quantity = quantity
        self.imageURL = imageURL
    }
}
