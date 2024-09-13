//
//  NutritionalValues.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

struct NutritionalValues {
    let calories: Int
    let protein: Int
    let fat: Int
    let carbohydrates: Int
    
    init(calories: Int, protein: Int, fat: Int, carbohydrates: Int) {
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
    }
}
