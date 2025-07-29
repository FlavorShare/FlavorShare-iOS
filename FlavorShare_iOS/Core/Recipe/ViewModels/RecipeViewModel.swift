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
    @Published var isPlanned: Bool = false
    
    @Published var newComment: String = ""
    @Published var rating: Int = 5
    @Published var userHasAlreadyReviewed: Bool = false
    @Published var hideCommentField: Bool = false
    
    @Published var selectedServings: Int
    @Published var showMealPlanningConfirmation: Bool = false
    
    init(recipe: Recipe, servings: Int? = nil) {
        self.recipe = recipe
        self.selectedServings = servings == nil ? recipe.servings : servings!
        
        getUser()
        updateIsLiked()
        updateIsPlanned()
        userHasAlreadyReviewed = recipe.reviews?.contains(where: { $0.ownerId == AuthService.shared.currentUser?.id }) ?? false
        
        if (userHasAlreadyReviewed) {
            guard let review = recipe.reviews?.first(where: { $0.ownerId == AuthService.shared.currentUser?.id }) else { return }
            newComment = review.comment
            rating = review.rating
            hideCommentField = true
        }
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
                    print("func getUser() - Error getting user: \(error.localizedDescription)")
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
                break
            case .failure(let error):
                print("func likeRecipe() - Error updating recipe: \(error.localizedDescription)")
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
                print("func likeRecipe() - Error updating user: \(error.localizedDescription)")
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
                break
            case .failure(let error):
                print("func unlikeRecipe() - Error updating recipe: \(error.localizedDescription)")
                self.likeRecipeUI()
            }
        }
        
        AuthService.shared.currentUser?.likedRecipes?.removeAll { $0 == self.recipe!.id }
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("func unlikeRecipe() - Error updating user: \(error.localizedDescription)")
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
    
    // MARK: - updateIsPlanned()
    /**
     This function updates the `isPlanned` property
     */
    func updateIsPlanned() {
        guard let mealPlanList = AuthService.shared.currentUser?.mealPlanList else {return}
                
        isPlanned = isRecipeInMealPlan(mealPlanList: mealPlanList)
    }
    
    // MARK: - isRecipeInMealPlan()
    /**
     This function checks if a recipe is in the meal plan
     */
    func isRecipeInMealPlan(mealPlanList: [MealPlanItem]) -> Bool {
        for mealPlanItem in mealPlanList {
            if mealPlanItem.recipe.id == recipe!.id {
                return true
            }
        }
        return false
    }
    
    // MARK: - addRecipeToMealPlan()
    /**
     This function is used to add a recipe to the meal plan
     */
    func addRecipeToMealPlan() {
        guard let _ = recipe else { return }
        guard let _ = AuthService.shared.currentUser else { return }
                
        isPlanned = true
        
        let mealPlanItem = MealPlanItem(recipe: recipe!, servings: selectedServings)
        
        AuthService.shared.currentUser!.mealPlanList?.append(mealPlanItem)
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!){ result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("func addRecipeToMealPlan() - Error updating user: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isPlanned = false
                }
                return
            }
        }
    }
    
    // MARK: - removeRecipeFromMealPlan()
    /**
     This function is used to remove a recipe from the meal plan
     */
    func removeRecipeFromMealPlan() {
        guard let _ = recipe else { return }
        guard let mealPlanList = AuthService.shared.currentUser?.mealPlanList else {return}
        
        // iterate through the user's mealPlanList to see if the recipe is already planned
        mealPlanList.forEach { mealPlanItem in
            if mealPlanItem.recipe.id == recipe?.id {
                AuthService.shared.currentUser!.mealPlanList?.removeAll { $0.id == mealPlanItem.id }
            }
        }
        
        isPlanned = false
        
        UserAPIService.shared.updateUser(id: AuthService.shared.currentUser!.id, user: AuthService.shared.currentUser!){ result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("func removeRecipeFromMealPlan() - Error updating user: \(error.localizedDescription)")
                self.isPlanned = true
                return
            }
        }
    }
    
    // MARK: - addReview()
    /**
     This function is used to add a review to the recipe
     */
    @Published var review: Review?
    func addReview() {
        guard let _ = recipe else { return }
        guard let _ = AuthService.shared.currentUser else { return }
        
        let newReview = Review(ownerId: AuthService.shared.currentUser!.id, rating: self.rating, comment: newComment)
        
        recipe!.reviews == nil ? recipe!.reviews = [newReview] : recipe!.reviews!.append(newReview)
        
        RecipeAPIService.shared.updateRecipe(id: self.recipe!.id, recipe: self.recipe!) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.hideCommentField = true
                }
            case .failure(let error):
                print("func addReview() - Error updating recipe: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - updateReview()
    /**
     This function is used to update a review
     */
    func updateReview() {
        guard let _ = recipe else { return }
        guard let _ = AuthService.shared.currentUser else { return }
        
        guard let reviewIndex = recipe!.reviews?.firstIndex(where: { $0.ownerId == AuthService.shared.currentUser?.id }) else { return }
        
        recipe!.reviews?[reviewIndex].comment = newComment
        recipe!.reviews?[reviewIndex].rating = rating
        
        RecipeAPIService.shared.updateRecipe(id: self.recipe!.id, recipe: self.recipe!) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.hideCommentField = true
                }
            case .failure(let error):
                print("func updateReview() - Error updating recipe: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: getReviewAuthor()
    /**
     This function fetches the review author
     */
    func getUserById(userId: String, completion: @escaping (User?) -> Void) {
        UserAPIService.shared.fetchUserById(withUid: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userFound):
                    completion(userFound)
                case .failure(let error):
                    print("func getUserById(userId: String, completion: @escaping (User?) -> Void) - Error updating user: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}
