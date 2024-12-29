//
//  MealPlanningViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-19.
//

import Foundation

class MealPlanningViewModel: ObservableObject {
    @Published var RecipePlanned: [Recipe] = []
    @Published var ingredients: [Ingredient] = []
    
//    init() {
//        getRecipePlanned()
//    }
    
    // MARK: - getRecipePlanned()
    /**
     This function fetches the meal plan list
     */
    func getRecipePlanned() {
        print("Fetching meal plan list")
        guard let mealPlanList = AuthService.shared.currentUser?.mealPlanList else { return }
        
        RecipePlanned = []
        ingredients = []
        
        print("Meal plan list")
        print(mealPlanList)
        
        RecipeAPIService.shared.fetchRecipesByIds(withIds: mealPlanList) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.RecipePlanned = recipes
                    print("Meal plan list fetched")
                    print(recipes)
                    self?.getIngredients()
                case .failure(let error):
                    print("Error fetching meal plan list")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - getIngredients()
    /**
     This function fetches the ingredients list
     */
    func getIngredients() {
        for (index, var recipe) in RecipePlanned.enumerated() {
            // Update ingredients within the recipe
            recipe.ingredients = recipe.ingredients.map { ingredient in
                var updatedIngredient = ingredient
                if updatedIngredient.isCompleted == nil {
                    updatedIngredient.isCompleted = false
                }
                return updatedIngredient
            }
            // Update the recipe in the array
            RecipePlanned[index] = recipe
            
            // Append the updated ingredients
            ingredients.append(contentsOf: recipe.ingredients)
        }
    }
    
    // MARK: - deleteRecipePlanned()
    /**
     This function clears the meal plan list
     */
    func deleteRecipePlanned() {
        AuthService.shared.currentUser?.mealPlanList = []
        RecipePlanned = []
        ingredients = []
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!) { result in
            switch result {
            case .success:
                print("Meal plan list cleared")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
