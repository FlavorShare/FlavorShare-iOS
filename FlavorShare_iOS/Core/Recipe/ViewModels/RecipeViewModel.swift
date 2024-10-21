//
//  RecipeViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-15.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe?
    @Published var isLiked: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
        getUser()
        updateIsLiked()
    }
    
    // MARK: - getUser()
    /**
     This function fetches the recipe's owner
     */
    func getUser() {
        guard let recipe = recipe else { return }
        
        UserAPIService.shared.fetchUserById(withUid: recipe.ownerId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.recipe?.user = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - updateIsLiked()
    /**
     This function updates the `isLiked` property
     */
    func updateIsLiked() {
        if recipe?.peopleWhoLiked?.contains(AuthService.shared.currentUser?.id ?? "") ?? false {
            isLiked = true
        } else {
            isLiked = false
        }
    }
    
    // MARK: - likeRecipe()
    /**
     This function is used to like a recipe
     */
    func likeRecipe() {
        guard let _ = recipe else { return }
        
        likeRecipeUI()
        
        RecipeAPIService.shared.updateRecipe(id: self.recipe!.id, recipe: self.recipe!) { result in
            switch result {
            case .success:
                print("Recipe liked updated")
            case .failure(let error):
                print(error.localizedDescription)
                self.unlikeRecipeUI()
                return
            }
        }
        
        AuthService.shared.currentUser?.likedRecipes?.append(self.recipe!.id)
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - unlikeRecipe()
    /**
     This function is used to unlike a recipe
     */
    func unlikeRecipe() {
        guard let _ = recipe else { return }
        
        unlikeRecipeUI()
        
        RecipeAPIService.shared.updateRecipe(id: self.recipe!.id, recipe: self.recipe!) { result in
            switch result {
            case .success:
                print("Recipe unliked updated")
            case .failure(let error):
                print(error.localizedDescription)
                self.likeRecipeUI()
            }
        }
        
        AuthService.shared.currentUser?.likedRecipes?.removeAll { $0 == self.recipe!.id }
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - likeRecipeUI()
    /**
     This function updates the UI when a recipe is liked
     */
    func likeRecipeUI() {
        guard let _ = recipe else { return }
        
        // Ensure the update to `isLiked` happens on the main thread.
        DispatchQueue.main.async {
            self.isLiked = true
        }
        
        self.recipe!.likes += 1
        self.recipe!.peopleWhoLiked?.append(AuthService.shared.currentUser?.id ?? "")
    }
    
    // MARK: - unlikeRecipeUI()
    /**
     This function updates the UI when a recipe is unliked
     */
    func unlikeRecipeUI() {
        guard let _ = recipe else { return }
        
        // Ensure the update to `isLiked` happens on the main thread.
        DispatchQueue.main.async {
            self.isLiked = false
        }
        
        self.recipe!.likes -= 1
        self.recipe!.peopleWhoLiked?.removeAll { $0 == AuthService.shared.currentUser?.id }
    }
    
   
}
