//
//  RecipeListViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var cuisineTypes: [String] = ["All"]
    
    init() {
        fetchRecipes()
        fetchCuisineTypes()
    }
    
    // MARK: Get Recipe List
    /**
     This function updates the recipes property for the RecipeListViewModel
     - Authors: Benjamin Lefebvre
     */
    func fetchRecipes() {
        isLoading = true
        RecipeAPIService.shared.fetchAllRecipes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let recipes):
                    self?.recipes = recipes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: Get Cuisine Categories
    /**
     This function updates the cuisineTypes property for the RecipeListViewModel
     - Authors: Benjamin Lefebvre
     */
    func fetchCuisineTypes() {
        RecipeAPIService.shared.fetchCuisineTypes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let types):
                    self.cuisineTypes.append(contentsOf: types)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
