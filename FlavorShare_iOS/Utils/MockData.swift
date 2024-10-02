//
//  File.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-15.
//

import Foundation

class MockData {
    static let shared = MockData()

    let user = User(
        id: "1",
        email: "test_email@gmail.com",
        username: "BengeeL",
        firstName: "John",
        lastName: "Doe",
        phone: "1233211234",
        dateOfBirth: Date()
    )
    
    let recipe = [
        Recipe(
            id: "1",
            title: "Spaghetti Carbonara",
            imageURL: "https://www.allrecipes.com/thmb/N3hqMgkSlKbPmcWCkHmxekKO61I=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Easyspaghettiwithtomatosauce_11715_DDMFS_1x2_2425-c67720e4ea884f22a852f0bb84a87a80.jpg",
            ownerId: "1",
            createdAt: Date(),
            updatedAt: Date(),
            description: "A classic Italian pasta dish.",
            ingredients: [Ingredient(name: "Spaghetti"), Ingredient(name: "Eggs"), Ingredient(name: "Pancetta"), Ingredient(name: "Parmesan Cheese"), Ingredient(name: "Black Pepper")],
            instructions: [Instruction(step: 1, description: "Boil the spaghetti."), Instruction(step: 2, description: "Cook the pancetta."), Instruction(step: 3, description: "Mix eggs and cheese."), Instruction(step: 4, description: "Combine all ingredients.")],
            cookTime: 30,
            servings: 4,
            likes: 100,
            type: "Italian",
            nutritionalValues: NutritionalValues(calories: 500, protein: 20, fat: 25, carbohydrates: 50),
            user: User(
                id: "1",
                email: "user@example.com",
                username: "user123",
                firstName: "John",
                lastName: "Doe",
                phone: "123-456-7890",
                dateOfBirth: Date(),
                createdAt: Date(),
                updatedAt: Date(),
                profileImageURL: nil,
                bio: "This is a bio"
            )
        )
    ]
}
