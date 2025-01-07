//
//  RecipeEditorViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI



struct RecipeEditorView: View {
    @StateObject private var viewModel = RecipeEditorViewModel()
    @State private var newIngredient: Ingredient = Ingredient(name: "", quantity: nil, unit: nil)
    @State private var newInstruction: Instruction = Instruction(step: 0, description: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isImagePickerPresented = false
    
    var isNewRecipe: Bool
    @Binding var recipe: Recipe?
    
    var quantityBinding: Binding<String> {
        Binding<String>(
            get: {
                // Convert the optional Int value to a String for display in the TextField
                if let quantity = newIngredient.quantity {
                    return String(quantity)
                } else {
                    return ""
                }
            },
            set: {
                // Convert the String back to an Int when the user types a new value
                newIngredient.quantity = Float($0)
            }
        )
    }
    
    init(isNewRecipe: Bool, recipe: Binding<Recipe?> = .constant(nil)) {
        self.isNewRecipe = isNewRecipe
        self._recipe = recipe
        
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            if let recipe = recipe {
                BackgroundView(imageURL: recipe.imageURL)
            }
            
            ScrollView {
                Text(isNewRecipe ? "New Recipe" : "Edit Recipe")
                    .font(.title)
                    .padding(.top, 60)
                    .padding(.horizontal)
                    .shadow(radius: 3)
                
                VStack (alignment: .leading) {
                    Text("Recipe Details")
                        .font(.headline)
                        .shadow(radius: 3)
                    
                    recipeDetails
                    
                    Text("Recipe Ingredients")
                        .font(.headline)
                        .shadow(radius: 3)
                        .padding(.top, 20)
                    
                    ingredients
                    
                    Text("Recipe Instructions")
                        .font(.headline)
                        .shadow(radius: 3)
                        .padding(.top, 20)
                    
                    instructions
                    
                    actionButtons
                } // end of Form
                .padding(.top)
                .padding(.bottom, 150)
                .padding(.horizontal)
            }
            .foregroundStyle(.white)
            
            HStack (alignment: .top) {
                // Back button to go back in navigation stack
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .clipped()
                        .shadow(radius: 3)
                }
                
                Spacer()
            } // end of HStack
            .padding(.top, 60)
            .padding(.horizontal)
        } // end of ZStack
        .background(.gray)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let recipe = recipe, !isNewRecipe {
                viewModel.loadRecipe(recipe)
            }
        }
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
        .gesture(
            DragGesture().onEnded { value in
                if value.location.x - value.startLocation.x > 150 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
    }
    
    var recipeDetails: some View {
        // MARK: - Recipe Details
        VStack (alignment: .leading) {
            VStack {
                TextField("", text: $viewModel.title, prompt: Text("Recipe Title").foregroundColor(.white.opacity(0.5))
                )
                
                Divider()
                    .overlay(.black)
                    .padding(.vertical, 5)
                
                TextField("", text: $viewModel.description, prompt: Text("Description").foregroundColor(.white.opacity(0.5)), axis: .vertical)
                
                Divider()
                    .overlay(.black)
                    .padding(.vertical, 5)
                
                Picker("Cuisine Type", selection: $viewModel.type) {
                    ForEach(viewModel.cuisineTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                
                Divider()
                    .overlay(.black)
                    .padding(.vertical, 5)
                
                Stepper(value: $viewModel.cookTime, in: 0...240) {
                    Text("Cook Time: \(viewModel.cookTime) minutes")
                }
                
                Divider()
                    .overlay(.black)
                    .padding(.vertical, 5)
                
                Stepper(value: $viewModel.servings, in: 1...20) {
                    Text("Servings: \(viewModel.servings)")
                }
                
                if (viewModel.imageURL != "") {
                    Divider()
                        .overlay(.black)
                        .padding(.vertical, 5)
                    
                    VStack (alignment: .center) {
                        Text("Current Image")
                        RemoteImageView(fileName: viewModel.imageURL, width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    }
                }
                
                
                if let selectedImage = viewModel.selectedImage {
                    Divider()
                        .overlay(.black)
                        .padding(.vertical, 5)
                    
                    VStack (alignment: .center) {
                        Text("New Image")
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                            .clipped()
                    }
                }
                
                Divider()
                    .overlay(.black)
                    .padding(.top)
                
                Button(action: {
                    viewModel.isImagePickerPresented = true
                }) {
                    Text("Select New Image")
                }
                .padding()
            }
            .padding()
        }
        .background(.black.opacity(0.5))
        .cornerRadius(10)
        .clipped()
        .tint(.white)
    }
    
    var ingredients: some View {
        // MARK: - Ingredients
        VStack {
            VStack {
                // *************** Existing ingredient ***************
                ForEach(viewModel.ingredients.indices, id: \.self) { index in
                    VStack {
                        TextField("", text: Binding(
                            get: { viewModel.ingredients[index].name },
                            set: { viewModel.ingredients[index].name = $0 }
                        ), prompt: Text("Ingredient Name").foregroundColor(.white.opacity(0.5))
                        )
                        
                        HStack {
                            TextField("", text: Binding<String>(
                                get: {
                                    if let quantity = viewModel.ingredients[index].quantity {
                                        return quantity.truncatingRemainder(dividingBy: 1) == 0
                                        ? String(format: "%.0f", quantity) // Show no decimals for round numbers
                                        : String(format: "%.1f", quantity) // Show one decimal for decimal numbers
                                    } else {
                                        return ""
                                    }
                                },
                                set: { newValue in
                                    if let floatValue = Float(newValue) {
                                        viewModel.ingredients[index].quantity = floatValue
                                    } else {
                                        viewModel.ingredients[index].quantity = nil
                                    }
                                }
                            ), prompt: Text("Quantity").foregroundColor(.white.opacity(0.5))
                            )
                            .keyboardType(.decimalPad)
                            
                            Spacer()
                            
                            Picker("Unit", selection: Binding(
                                get: { viewModel.ingredients[index].unit ?? "" },
                                set: { viewModel.ingredients[index].unit = $0.isEmpty ? nil : $0 }
                            )) {
                                ForEach(viewModel.units, id: \.self) { unit in
                                    Text(unit).tag(unit)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        Divider()
                            .overlay(.black)
                            .padding(.vertical, 5)
                    }
                }
                .onDelete { indexSet in
                    viewModel.ingredients.remove(atOffsets: indexSet)
                }
                
                // *************** New ingredient ***************
                VStack {
                    TextField("Search for an ingredient", text: $newIngredient.name, prompt: Text("New Ingredient").foregroundColor(.white.opacity(0.5))
                    )
                    .onChange(of: newIngredient.name) {
                        viewModel.searchFoodItems(for: newIngredient.name)
                    }
                    
                    ForEach(viewModel.filteredFoodItems, id: \._id) { item in
                        Button(action: {
                            newIngredient.name = item.name.capitalized
                            viewModel.filteredFoodItems = []
                        }) {
                            HStack {
                                Text(item.name.capitalized)
                                
                                Spacer()
                                
                                Text(item.category)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    List(viewModel.foodItems, id: \._id) { item in
                        Text(item.name)
                            .onAppear {
                                print("Rendering item: \(item.name)")
                            }
                    }
                    
                    HStack {
                        TextField("", text: quantityBinding, prompt: Text("Quantity").foregroundColor(.white.opacity(0.5)))
                            .keyboardType(.decimalPad)
                        
                        Spacer()
                        
                        Picker("Unit", selection: $newIngredient.unit) {
                            ForEach(viewModel.units, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        //                        .frame(width: 110)
                        .padding(.bottom, 5)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if !newIngredient.name.isEmpty {
                                viewModel.ingredients.append(newIngredient)
                                newIngredient = Ingredient(name: "", quantity: nil, unit: nil)
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                    .padding(.top, 10)
                    
                }
            }
            .padding()
        }
        .background(.black.opacity(0.5))
        .cornerRadius(10)
        .clipped()
        .tint(.white)
    }
    
    
    var instructions: some View {
        // MARK: - Instructions
        VStack (spacing: 0) {
            VStack (spacing: 0) {
                // *************** Existing instruction ***************
                ForEach(viewModel.instructions.indices, id: \.self) { index in
                    InstructionView(
                        instruction: $viewModel.instructions[index],
                        ingredients: $viewModel.ingredients
                    )
                    
                    Divider()
                        .overlay(.black)
                        .padding(.vertical)
                }
                .onDelete { indexSet in
                    viewModel.ingredients.remove(atOffsets: indexSet)
                    updateInstructionSteps()
                    
                }
                
                // *************** New Instructions ***************
                VStack (alignment: .leading) {
                    Text("Step \(viewModel.instructions.count + 1)")
                        .font(.headline)
                    
                    TextField("", text: $newInstruction.description, prompt: Text("New Instruction").foregroundColor(.white.opacity(0.5)), axis: .vertical)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if !newInstruction.description.isEmpty {
                                let nextIndex = viewModel.instructions.count + 1
                                newInstruction.step = nextIndex
                                viewModel.instructions.append(newInstruction)
                                newInstruction = Instruction(step: 0, description: "")
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .padding()
        }
        .background(.black.opacity(0.5))
        .cornerRadius(10)
        .clipped()
        .tint(.white)
    }
    
    var actionButtons: some View {
        // MARK: - Save / Delete Buttons
        VStack (spacing: 0) {
            if !isNewRecipe {
                Button(action: {
                    viewModel.deleteRecipe { success in
                        if success {
                            self.recipe = nil
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            alertMessage = viewModel.errorMessage ??  "Failed to delete recipe. Please try again."
                            showAlert = true
                        }
                    }
                }) {
                    Text("Delete Recipe")
                        .foregroundColor(.red)
                }
                .padding()
            }
            
            Divider()
                .overlay(.black)
                .padding(0)
            
            Button(action: {
                if isNewRecipe {
                    viewModel.createRecipe { success in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            alertMessage = viewModel.errorMessage ?? "Failed to create recipe. Please try again."
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
                            alertMessage = viewModel.errorMessage ?? "Failed to update recipe. Please try again."
                            showAlert = true
                        }
                    }
                }
            }) {
                Text(isNewRecipe ? "Create Recipe" : "Update Recipe")
            }
            .padding()
            
        } // end of Section
        .background(.black.opacity(0.5))
        .cornerRadius(10)
        .clipped()
        .padding(.top)
        .tint(.white)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helper Functions
    func updateInstructionSteps() {
        for (index, _) in viewModel.instructions.enumerated() {
            viewModel.instructions[index].step = index + 1
        }
    }
}

struct InstructionView: View {
    @Binding var instruction: Instruction
    @Binding var ingredients: [Ingredient]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Step \(instruction.step)")
                .font(.headline)
            
            TextField("Description", text: $instruction.description, axis: .vertical)
            
            // Custom list for multiple selection
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                ForEach($ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient.name.wrappedValue)
                        
                        Spacer()
                        
                        Image(systemName: instruction.ingredients?.contains(ingredient._id.wrappedValue) == true ? "checkmark.circle.fill" : "circle")
                    }
                    .onTapGesture {
                        toggleIngredientSelection(ingredient.wrappedValue)
                    }
                    .contentShape(Rectangle()) // Make the whole row tappable
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    private func toggleIngredientSelection(_ ingredient: Ingredient) {
        if instruction.ingredients?.contains(ingredient._id) == true {
            instruction.ingredients?.removeAll { $0 == ingredient._id }
        } else {
            instruction.ingredients?.append(ingredient._id)
        }
    }
}


#Preview {
    RecipeEditorView(isNewRecipe: true, recipe: .constant(MockData.shared.recipe[0]))
}
