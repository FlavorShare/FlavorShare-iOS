//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeView: View {
    @State var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Recipe Image
                if (recipe.imageURL != "") {
                    let url = URL(string: recipe.imageURL)
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }    
                
                // Recipe Title
                Text(recipe.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Recipe Owner
                if let user = recipe.user {
                    HStack {
                        if let url = URL(string: user.profileImageURL ?? "") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(user.username)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Recipe Description
                Text(recipe.description)
                    .font(.body)
                    .padding(.horizontal)
                
                // Recipe Ingredients
                Text("Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient.name)
                        .padding(.horizontal)
                }
                
                // Recipe Instructions
                Text("Instructions")
                    .font(.headline)
                    .padding(.horizontal)
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(recipe.instructions[index].description)")
                        .padding(.horizontal)
                }
                
                // Recipe Details
                HStack {
                    Text("Cook Time: \(recipe.cookTime) minutes")
                    Spacer()
                    Text("Servings: \(recipe.servings)")
                }
                .padding(.horizontal)
                
                // Recipe Likes
                HStack {
                    Text("Likes: \(recipe.likes)")
                    Spacer()
                    Text("Cuisine Type: \(recipe.type)")
                }
                .padding(.horizontal)
                
                // Nutritional Values
                if let nutritionalValues = recipe.nutritionalValues {
                    Text("Nutritional Values")
                        .font(.headline)
                        .padding(.horizontal)
                    Text("Calories: \(nutritionalValues.calories)")
                        .padding(.horizontal)
                    Text("Protein: \(nutritionalValues.protein)g")
                        .padding(.horizontal)
                    Text("Fat: \(nutritionalValues.fat)g")
                        .padding(.horizontal)
                    Text("Carbohydrates: \(nutritionalValues.carbohydrates)g")
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Recipe Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: RecipeEditorView(isNewRecipe: false, recipe: Binding(get: { Optional(recipe) }, set: { recipe = $0! }))) {
                    Text("Edit")
                }
            }
        }
    }
}

#Preview {
    RecipeView(recipe: Recipe(
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
            profileImageURL: nil,
            bio: "This is a bio",
            isFollowed: false,
            stats: UserStats(followers: 100, following: 50, posts: 10),
            isCurrentUser: false
        )
    )
    )
}
