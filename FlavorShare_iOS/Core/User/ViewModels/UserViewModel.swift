//
//  UserViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-01.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var user: User
    @Published var recipes: [Recipe] = []
    
    init(user: User) {
        self.user = user
        self.fetchRecipes()
    }
    
    /**
        This function fetches the user's recipes
     */
    func fetchRecipes() {
        RecipeAPIService.shared.fetchRecipes(for: user) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self?.recipes = recipes
                case .failure(let error):
                    print("func fetchRecipes() - Error getting user recipes: \(error.localizedDescription)")
                }
            }
        }
    }
}
