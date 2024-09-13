//
//  Ingredient.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct Ingredient {
    let name: String
    let quantity: String
    let imageURL: String?
    
    init(name: String, quantity: String, imageURL: String?) {
        self.name = name
        self.quantity = quantity
        self.imageURL = imageURL
    }
}
