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
        print("Showing User View")
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
    
    func fetchUpdatedUserData() {
        self.user.profileImageURL = nil
        UserAPIService.shared.fetchUserById(withUid: user.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    print("func fetchUpdatedUserData() - Error fetching user data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func refreshView() {
        print("Refreshing view...")
        fetchRecipes()
        fetchUpdatedUserData()
    }
}
