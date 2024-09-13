//
//  RecipeListViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [RecipeAPIService.Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var cuisineTypes: [String] = ["All"]

    init() {
        fetchRecipes()
        fetchCuisineTypes()
    }
    
    func fetchRecipes() {
        isLoading = true
        RecipeAPIService.shared.fetchRecipes { [weak self] result in
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
