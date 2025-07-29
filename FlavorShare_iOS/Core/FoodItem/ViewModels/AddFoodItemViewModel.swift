//
//  AddFoodItemViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-04.
//

import Foundation

class AddFoodItemViewModel: ObservableObject {
    @Published var names: String = ""
    @Published var category: String = ""
    
    func addFoodItem() {
        let foodItem = FoodItem(name: names, category: category)
        
        FoodItemAPIService.shared.createFoodItem(foodItem: foodItem) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
               print("func addFoodItem() - Error creating foodItem: \(error)")
            }
        }
    }
    
    func addFoodItems() {
        let nameArray = names.split(separator: ", ")
        let foodItems = nameArray.map { FoodItem(name: String($0).capitalized, category: category.capitalized) }
        
        FoodItemAPIService.shared.createFoodItems(foodItems: foodItems) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.names = ""
                    self.category = ""
                case .failure(let error):
                    print("func addFoodItems() - Error creating foodItems: \(error)")
                }
            }
        }
    }
}
