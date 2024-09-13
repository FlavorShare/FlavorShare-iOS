//
//  RecipeEditorViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI

struct RecipeEditorView: View {
    @StateObject private var viewModel = RecipeEditorViewModel()
    @State private var newIngredient: String = ""
    @State private var newInstruction: String = ""

    @Environment(\.presentationMode) var presentationMode

    @State private var showAlert = false
    @State private var alertMessage = ""

    var isNewRecipe: Bool
    @Binding var recipe: Recipe?

    init(isNewRecipe: Bool, recipe: Binding<Recipe?> = .constant(nil)) {
        self.isNewRecipe = isNewRecipe
        self._recipe = recipe
    }

    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Title", text: $viewModel.title)
                TextField("Image URL", text: $viewModel.imageURL)
                TextField("Owner ID", text: $viewModel.ownerId)
                DatePicker("Created At", selection: $viewModel.createdAt, displayedComponents: .date)
                DatePicker("Updated At", selection: $viewModel.updatedAt, displayedComponents: .date)
                TextField("Description", text: $viewModel.description)
                Picker("Cuisine Type", selection: $viewModel.type) {
                    ForEach(viewModel.cuisineTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                Stepper(value: $viewModel.cookTime, in: 0...240) {
                    Text("Cook Time: \(viewModel.cookTime) minutes")
                }
                Stepper(value: $viewModel.servings, in: 1...20) {
                    Text("Servings: \(viewModel.servings)")
                }
                Stepper(value: $viewModel.likes, in: 0...10000) {
                    Text("Likes: \(viewModel.likes)")
                }
            }

            Section(header: Text("Ingredients")) {
                ForEach(viewModel.ingredients, id: \.self) { ingredient in
                    Text("\(ingredient.name) - \(ingredient.quantity ?? 0)")
                }
                HStack {
                    TextField("New Ingredient", text: $newIngredient)
                    Button(action: {
                        if !newIngredient.isEmpty {
                            viewModel.ingredients.append(Ingredient(name: newIngredient))
                            newIngredient = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }

            Section(header: Text("Instructions")) {
                ForEach(viewModel.instructions.indices, id: \.self) { index in
                    let instruction = viewModel.instructions[index]
                    Text("\(instruction.step). \(instruction.description)")
                }
                HStack {
                    TextField("New Instruction", text: $newInstruction)
                    Button(action: {
                        if !newInstruction.isEmpty {
                            let nextIndex = viewModel.instructions.count + 1
                            viewModel.instructions.append(Instruction(step: nextIndex, description: newInstruction))
                            newInstruction = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }

            Section {
                Button(action: {
                    if isNewRecipe {
                        viewModel.createRecipe { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertMessage = "Failed to create recipe. Please try again."
                                showAlert = true
                            }
                        }
                    } else {
                        viewModel.updateRecipe { success in
                            if success {
                                // Update the recipe binding with the new data
                                recipe = Recipe(
                                    id: viewModel.id,
                                    title: viewModel.title,
                                    imageURL: viewModel.imageURL,
                                    ownerId: viewModel.ownerId,
                                    createdAt: viewModel.createdAt,
                                    updatedAt: viewModel.updatedAt,
                                    description: viewModel.description,
                                    ingredients: viewModel.ingredients,
                                    instructions: viewModel.instructions,
                                    cookTime: viewModel.cookTime,
                                    servings: viewModel.servings,
                                    likes: viewModel.likes,
                                    type: viewModel.type,
                                    nutritionalValues: viewModel.nutritionalValues,
                                    user: viewModel.user
                                )
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertMessage = "Failed to update recipe. Please try again."
                                showAlert = true
                            }
                        }
                    }
                }) {
                    Text(isNewRecipe ? "Create Recipe" : "Update Recipe")
                }
            }
        }
        .navigationTitle(isNewRecipe ? "New Recipe" : "Edit Recipe")
        .onAppear {
            if let recipe = recipe, !isNewRecipe {
                viewModel.loadRecipe(recipe)
            }
            viewModel.fetchCuisineTypes() // Ensure cuisine types are fetched
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditorView(isNewRecipe: true, recipe: .constant(Recipe(
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
        )))
    }
}
