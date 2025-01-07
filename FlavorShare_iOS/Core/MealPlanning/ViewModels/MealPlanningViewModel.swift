//
//  MealPlanningViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-19.
//

import Foundation

class MealPlanningViewModel: ObservableObject {
    @Published var RecipePlanned: [Recipe] = []
    @Published var groceryFoodItems: [FoodItem] = []
    @Published var units: [String] = ["", "g", "kg", "ml", "l", "tsp", "tbsp", "cup", "oz", "lb", "unit"]
    @Published var quantityItems = 0
    
    @Published var categorizedGroceryItems: [String: [FoodItem]] = [:] {
        didSet {
            updateQuantityItems()
            saveCategorizedGroceryItemsToLocalStorage()
        }
    }
    
    @Published var savedMealPlanList: [MealPlanItem]? = nil {
        didSet {
            saveMealPlanListToLocalStorage()
        }
    }
    
    // MARK: - updateMealPlan()
    /**
     This function updates the meal plan list
    */
    func updateMealPlan() {
        loadMealPlanListFromLocalStorage()
        
        if let mealPlanList = savedMealPlanList,
           let currentUserMealPlanList = AuthService.shared.currentUser?.mealPlanList,
           mealPlanList == currentUserMealPlanList {
            loadCategorizedGroceryItemsFromLocalStorage()
        } else {
            categorizedGroceryItems = [:]
            savedMealPlanList = nil
        }
        
        getRecipePlanned()
    }
    
    // MARK: - SAVING/LOADING FUNCTIONS LOCAL STORAGE
    func saveCategorizedGroceryItemsToLocalStorage() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(categorizedGroceryItems) {
            UserDefaults.standard.set(encoded, forKey: "categorizedGroceryItems")
        }
    }
    
    func saveMealPlanListToLocalStorage() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedMealPlanList) {
            UserDefaults.standard.set(encoded, forKey: "mealPlanList")
        }
    }
    
    private func loadCategorizedGroceryItemsFromLocalStorage() {
        if let savedData = UserDefaults.standard.data(forKey: "categorizedGroceryItems") {
            let decoder = JSONDecoder()
            if let loadedItems = try? decoder.decode([String: [FoodItem]].self, from: savedData) {
                categorizedGroceryItems = loadedItems
            }
        }
    }
    
    private func loadMealPlanListFromLocalStorage() {
        if let savedData = UserDefaults.standard.data(forKey: "mealPlanList") {
            let decoder = JSONDecoder()
            if let loadedItems = try? decoder.decode([MealPlanItem].self, from: savedData) {
                savedMealPlanList = loadedItems
            }
        }
    }
    
    // MARK: - updateQuantityItems()
    /**
     This function updates the quantity of grecery items in CategorizedGroceryItems
     */
    func updateQuantityItems() {
        quantityItems = 0
        
        for (_, value) in categorizedGroceryItems {
            for item in value {
                if item.isCompleted == false {
                    quantityItems += 1
                }
            }
        }
    }
    
    // MARK: - getNumberOfServings()
    /**
     This function fetches the number of servings
     - Parameter recipe: The recipe
     - Returns: The number of servings
     */
    func getNumberOfServings(for recipe: Recipe) -> Int {
        guard let mealPlanList = AuthService.shared.currentUser?.mealPlanList else { return 0 }
        
        for mealPlan in mealPlanList {
            if mealPlan.recipe.id == recipe.id {
                return mealPlan.servings
            }
        }
        
        return 0
    }
    
    // MARK: - getRecipePlanned()
    /**
     This function fetches the meal plan list
     */
    func getRecipePlanned() {
        guard let mealPlanList = AuthService.shared.currentUser?.mealPlanList else { return }
        
        RecipePlanned = []
        groceryFoodItems = []
        
        for mealPlan in mealPlanList {
            self.addGroceryFoodItems(for: mealPlan.recipe, servings: mealPlan.servings)
            
            RecipePlanned.append(mealPlan.recipe)
        }
        
        if (categorizedGroceryItems == [:]) {
            categorizeGroceryItems()
            savedMealPlanList = AuthService.shared.currentUser?.mealPlanList
        }
    }
    
    // MARK: - getIngredients()
    /**
     This function fetches the ingredients list
     */
    func addGroceryFoodItems(for recipe: Recipe, servings: Int) {
        // Get each ingredient from the recipe
        for ingredient in recipe.ingredients {
            // Get FoodItem from ingredient
            var foodItem = queryFoodItem(byName: ingredient.name)
            
            // Set quantity
            if foodItem.quantity == nil && ingredient.quantity != nil {
                foodItem.quantity = (ingredient.quantity! / Float(recipe.servings) * Float(servings))
            }
            
            // Set Unit
            if foodItem.unit == nil {
                foodItem.unit = ingredient.unit
            }
            
            // Set isCompleted
            if foodItem.isCompleted == nil {
                foodItem.isCompleted = false
            }
            
            // Look if foodItem is already in the groceryFoodItems array
            var alreadyInGroceryFoodList = false
            var groceryFoodItemsIndex: Int? = nil
            for (index, existingFoodItem) in groceryFoodItems.enumerated() {
                
                let shouldBeUpdated = existingFoodItem.id == foodItem.id && existingFoodItem.unit == foodItem.unit
                
                if shouldBeUpdated {
                    alreadyInGroceryFoodList = true
                    groceryFoodItemsIndex = index
                    break
                }
            }
            
            if alreadyInGroceryFoodList, let index = groceryFoodItemsIndex {
                groceryFoodItems[index].quantity! += foodItem.quantity!
            } else {
                groceryFoodItems.append(foodItem)
            }
        }
    }
    
    // MARK: - queryFoodItem()
    /**
     This function queries a food item by name
     - Parameter name: The name of the food item
     - Returns: The food item found or a new food item
     */
    func queryFoodItem(byName name: String) -> FoodItem {
        if let foodItemFound = FoodItemsList.shared.foodItems.first(where: { $0.name == name }) {
            return foodItemFound
        } else {
            let newFoodItem = FoodItem(name: name, category: "Other")
            FoodItemsList.shared.foodItems.append(newFoodItem)
            return newFoodItem
        }
    }
    
    // MARK: - categorizeGroceryItems()
    /**
     This function categorizes the grocery items
     */
    func categorizeGroceryItems() {
        var categorizedItems: [String: [FoodItem]] = [:]
        
        for item in groceryFoodItems {
            if categorizedItems[item.category] != nil {
                categorizedItems[item.category]?.append(item)
            } else {
                categorizedItems[item.category] = [item]
            }
        }
        
        self.categorizedGroceryItems = categorizedItems
    }
    
    // MARK: - deleteRecipePlanned()
    /**
     This function clears the meal plan list
     */
    func deleteRecipePlanned() {
        AuthService.shared.currentUser?.mealPlanList = []
        RecipePlanned = []
        groceryFoodItems = []
        categorizedGroceryItems = [:]
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("func deleteRecipePlanned() - Error deleting meal plan: \(error.localizedDescription)")
            }
        }
    }
}
