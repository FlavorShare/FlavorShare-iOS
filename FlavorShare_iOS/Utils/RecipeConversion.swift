//
//  RecipeConversion.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation

func convertToRecipe(apiRecipe: RecipeAPIService.Recipe) -> Recipe {
    return Recipe(
        id: apiRecipe.id,
        title: apiRecipe.title,
        imageURL: apiRecipe.imageURL,
        ownerId: apiRecipe.ownerId,
        createdAt: apiRecipe.createdAt,
        updatedAt: apiRecipe.updatedAt,
        description: apiRecipe.description,
        ingredients: apiRecipe.ingredients.map { convertToIngredient(apiIngredient: $0) },
        instructions: apiRecipe.instructions.map { convertToInstruction(apiInstruction: $0) },
        cookTime: apiRecipe.cookTime,
        servings: apiRecipe.servings,
        likes: apiRecipe.likes,
        type: apiRecipe.type,
        nutritionalValues: apiRecipe.nutritionalValues.map { convertToNutritionalValues(apiNutritionalValues: $0) },
        user: apiRecipe.user.map { convertToUser(apiUser: $0) }
    )
}

func convertToIngredient(apiIngredient: RecipeAPIService.Ingredient) -> Ingredient {
    return Ingredient(
        name: apiIngredient.name,
        quantity: Int(apiIngredient.quantity) ?? 1,
        imageURL: apiIngredient.imageURL
    )
}

func convertToInstruction(apiInstruction: RecipeAPIService.Instruction) -> Instruction {
    return Instruction(
        step: apiInstruction.step,
        description: apiInstruction.description
    )
}

func convertToNutritionalValues(apiNutritionalValues: APINutritionalValues) -> NutritionalValues {
    return NutritionalValues(
        calories: apiNutritionalValues.calories,
        protein: apiNutritionalValues.protein,
        fat: apiNutritionalValues.fat,
        carbohydrates: apiNutritionalValues.carbohydrates
    )
}

func convertToUser(apiUser: APIUser) -> User {
    return User(
        id: apiUser.id,
        email: apiUser.email,
        username: apiUser.username,
        firstName: apiUser.firstName,
        lastName: apiUser.lastName,
        phone: apiUser.phone,
        dateOfBirth: apiUser.dateOfBirth,
        profileImageURL: apiUser.profileImageURL,
        bio: apiUser.bio,
        isFollowed: apiUser.isFollowed,
        stats: apiUser.stats.map { convertToUserStats(apiUserStats: $0) },
        isCurrentUser: apiUser.isCurrentUser
    )
}

func convertToUserStats(apiUserStats: APIUserStats) -> UserStats {
    return UserStats(
        followers: apiUserStats.followers,
        following: apiUserStats.following,
        posts: apiUserStats.posts
    )
}
