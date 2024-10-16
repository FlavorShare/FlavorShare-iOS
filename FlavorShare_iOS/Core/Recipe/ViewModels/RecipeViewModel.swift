//
//  RecipeViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-15.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        getUser()
    }
    
    func getUser() {
        UserAPIService.shared.fetchUserById(withUid: recipe.ownerId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.recipe.user = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
