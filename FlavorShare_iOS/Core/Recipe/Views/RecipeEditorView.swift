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
    @State private var isImagePickerPresented = false

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
                
                if (viewModel.imageURL != "") {
                    VStack {
                        Text("Current Image")
                        RemoteImageView(fileName: viewModel.imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    }
                }
                
                if let selectedImage = viewModel.selectedImage {
                    VStack {
                        Text("New Image")
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
                    }
                }
                
                Button(action: {
                    viewModel.isImagePickerPresented = true
                }) {
                    Text("Select Image")
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
                if !isNewRecipe {
                    Button(action: {
                        viewModel.deleteRecipe { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                alertMessage = "Failed to delete recipe. Please try again."
                                showAlert = true
                            }
                        }
                    }) {
                        Text("Delete Recipe")
                            .foregroundColor(.red)
                    }
                }
                
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
        } // end of Form
        .navigationTitle(isNewRecipe ? "New Recipe" : "Edit Recipe")
        .onAppear {
            if let recipe = recipe, !isNewRecipe {
                viewModel.loadRecipe(recipe)
            }
        }
        .padding(.bottom, 150)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(image: $viewModel.selectedImage, isPresented: $viewModel.isImagePickerPresented)
        }
    }
}

#Preview {
    RecipeEditorView(isNewRecipe: true, recipe: .constant(MockData.shared.recipe[0]))
}
