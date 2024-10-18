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
                newIngredient.quantity = Int($0)
            }
        )
    }
    
    init(isNewRecipe: Bool, recipe: Binding<Recipe?> = .constant(nil)) {
        self.isNewRecipe = isNewRecipe
        self._recipe = recipe
    }
    
    var body: some View {
        ZStack {
            
            Form {
                recipeDetails
                ingredients
                instructions
                
                actionButtons
                
                // MARK: - PADDING FOR BOTTOM
                Divider()
                    .background(Color.clear)
                    .padding(.vertical, 15)
                
            } // end of Form
        }
        .navigationTitle(isNewRecipe ? "New Recipe" : "Edit Recipe")
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
    }
    
    var recipeDetails: some View {
        // MARK: - Recipe Details
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
    }
    
    var ingredients: some View {
        // MARK: - Ingredients
        Section(header: Text("Ingredients")) {
            
            // *************** Existing ingredient ***************
            ForEach(viewModel.ingredients.indices, id: \.self) { index in
                VStack {
                    TextField("Ingredient Name", text: Binding(
                        get: { viewModel.ingredients[index].name },
                        set: { viewModel.ingredients[index].name = $0 }
                    ))
                    
                    HStack {
                        TextField("Quantity", text: Binding(
                            get: { viewModel.ingredients[index].quantity.map(String.init) ?? "" },
                            set: { viewModel.ingredients[index].quantity = Int($0) }
                        ))
                        .keyboardType(.numberPad)
                        
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
                        .frame(width: 110)
                    }
                }
            }
            .onDelete { indexSet in
                viewModel.ingredients.remove(atOffsets: indexSet)
            }
            
            // *************** New ingredient ***************
            VStack {
                TextField("New Ingredient", text: $newIngredient.name)
                
                HStack {
                    TextField("Quantity", text: quantityBinding)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                    
                    Picker("Unit", selection: $newIngredient.unit) {
                        ForEach(viewModel.units, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 110)
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
                    }
                }
            }
        }
    }
    
    
    var instructions: some View {
        // MARK: - Instructions
        Section(header: Text("Instruction")) {
            
            // *************** Existing instruction ***************
            ForEach(viewModel.instructions.indices, id: \.self) { index in
                VStack (alignment: .leading) {
                    Text("Step \(viewModel.instructions[index].step)")
                        .font(.headline)
                    
                    TextField("Description", text: Binding(
                        get: { viewModel.instructions[index].description },
                        set: { viewModel.instructions[index].description = $0 }
                    ), axis: .vertical)
                    
                    
                    //
                    //                    Picker("Ingredients", selection: Binding(
                    //                        get: { viewModel.instructions[index].ingredients ?? [] },
                    //                        set: { viewModel.instructions[index].ingredients = $0.isEmpty ? [] : $0 }
                    //                    )) {
                    //                        ForEach(viewModel.recipe.ingredients, id: \.self) { ingredients in
                    //                            Text(ingredients).tag(ingredients)
                    //                        }
                    //                    }
                    //                    .pickerStyle(.inline)
                    //                    .frame(width: 110)
                    
                }
            }
            .onDelete { indexSet in
                viewModel.ingredients.remove(atOffsets: indexSet)
                updateInstructionSteps()
                
            }
            .onMove { indices, newOffset in
                viewModel.instructions.move(fromOffsets: indices, toOffset: newOffset)
                updateInstructionSteps()
            }
            
            // *************** New Instructions ***************
            VStack (alignment: .leading) {
                Text("Step \(viewModel.instructions.count + 1)")
                    .font(.headline)
                
                TextField("New Instruction", text: $newInstruction.description, axis: .vertical)

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
    }
    
    
    //    var instructions: some View {
    //        // MARK: - Instructions
    //        Section(header: Text("Instructions")) {
    //
    //            // *************** Existing Instructions ***************
    //            ForEach(viewModel.instructions) { instruction in
    //                VStack {
    //                    Text("Step \(instruction.step)")
    //                        .font(.headline)
    //
    //                    TextField("Step Description", text: Binding(
    //                        get: { instruction.description },
    //                        set: { newValue in
    //                            if let index = viewModel.instructions.firstIndex(where: { $0.id == instruction.id }) {
    //                                viewModel.instructions[index].description = newValue
    //                            }
    //                        }
    //                    ), axis: .vertical)
    //
    ////                    ForEach(instruction.ingredients ?? [], id: \.self) { ingredient in
    ////                        Button(action: {
    ////                            if let index = viewModel.instructions.firstIndex(where: { $0.id == instruction.id }) {
    ////                                viewModel.instructions[index].ingredients?.removeAll(where: { $0 == ingredient })
    ////                            } else {
    ////                                viewModel.instructions[index].ingredients?.append(ingredient)
    ////                            })
    ////                        }) {
    ////                            Text(ingredient.name)
    ////                        }
    ////                    }
    //                    LazyVStack {
    //                        if let ingredients = viewModel.recipe?.ingredients {
    //                            ForEach(0..<ingredients.count, id: \.self) { index in
    //                                let ingredient = ingredients[index]
    //                                Button(action: {
    //                                    if let instructionIndex = viewModel.instructions.firstIndex(where: { $0.id == instruction.id }) {
    //                                        if let ingredientIndex = viewModel.instructions[instructionIndex].ingredients?.firstIndex(of: ingredient) {
    //                                            viewModel.instructions[instructionIndex].ingredients?.remove(at: ingredientIndex)
    //                                        } else {
    //                                            viewModel.instructions[instructionIndex].ingredients?.append(ingredient)
    //                                        }
    //                                    }
    //                                }) {
    //                                    Text(ingredient.name)
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    ////
    ////                Picker("Ingredients", selection: Binding(
    ////                    get: {
    ////                        Set(instruction.ingredients ?? [])
    ////                    },
    ////                    set: { selectedIngredients in
    ////                        if let index = viewModel.instructions.firstIndex(where: { $0.id == instruction.id }) {
    ////                            viewModel.instructions[index].ingredients = Array(selectedIngredients)
    ////                        }
    ////                    }
    ////                )) {
    ////                    ForEach(viewModel.ingredients, id: \.self) { ingredient in
    ////                        Text(ingredient.name).tag(ingredient)
    ////                    }
    ////                }
    ////                .pickerStyle(.inline)
    ////                .padding(.top, 5)
    //
    //            }
    //            .onDelete { indexSet in
    //                viewModel.instructions.remove(atOffsets: indexSet)
    //                updateInstructionSteps()
    //            }
    //
    //            .onMove { indices, newOffset in
    //                viewModel.instructions.move(fromOffsets: indices, toOffset: newOffset)
    //                updateInstructionSteps()
    //            }
    //
    //
    //            // *************** New Instructions ***************
    //            HStack {
    //                TextField("New Instruction", text: $newInstruction.description)
    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
    //
    //                Button(action: {
    //                    if !newInstruction.description.isEmpty {
    //                        let nextIndex = viewModel.instructions.count + 1
    //                        newInstruction.step = nextIndex
    //                        viewModel.instructions.append(newInstruction)
    //                        newInstruction = Instruction(step: 0, description: "")
    //                    }
    //                }) {
    //                    Image(systemName: "plus.circle.fill")
    //                        .font(.title2)
    //                }
    //            }
    //            .padding(.top, 10)
    //        }
    //    }
    //
    //    var instructions: some View {
    //        // MARK: - Instructions
    //        Section(header: Text("Instructions")) {
    //
    //            // *************** Existing Instructions ***************
    //            ForEach($viewModel.instructions) { $instruction in
    //                VStack(alignment: .leading) {
    //                    Text("Step \(instruction.step)")
    //                        .font(.headline)
    //
    //                    TextField(
    //                        "Step Description",
    //                        text: $instruction.description,
    //                        axis: .vertical
    //                    )
    //
    ////                    Picker("Unit", selection: $instruction.ingredients) {
    ////                        ForEach(viewModel.recipe.ingredients, id: \.self) { ingredients in
    ////                            Text(ingredients).tag(ingredients)
    ////                        }
    ////                    }
    ////                    .pickerStyle(.navigationLink)
    ////                    .frame(width: 110)
    ////                    .padding(.bottom, 5)
    //
    //                    // Display ingredients using LazyVStack for better performance
    ////                    LazyVStack {
    ////                        if let ingredients = viewModel.recipe?.ingredients {
    ////                            ForEach(ingredients.indices, id: \.self) { index in
    ////                                let ingredient = ingredients[index]
    ////                                Button(action: {
    ////                                    // Toggle the selection of the ingredient
    ////                                    if let ingredientIndex = instruction.ingredients?.firstIndex(of: ingredient) {
    ////                                        instruction.ingredients?.remove(at: ingredientIndex)
    ////                                    } else {
    ////                                        instruction.ingredients?.append(ingredient)
    ////                                    }
    ////                                }) {
    ////                                    HStack {
    ////                                        Text(ingredient.name)
    ////                                            .foregroundColor(.primary)
    ////
    ////                                        Spacer()
    ////
    ////                                        if instruction.ingredients?.contains(ingredient) == true {
    ////                                            Image(systemName: "checkmark")
    ////                                                .foregroundColor(.green)
    ////                                        }
    ////                                    }
    ////                                    .padding(.vertical, 5)
    ////                                    .padding(.horizontal)
    ////                                    .background(Color(UIColor.systemGray6))
    ////                                    .cornerRadius(5)
    ////                                }
    ////                            }
    ////                        }
    ////                    }
    ////                    .padding(.top, 5)
    //                }
    //                .padding(.vertical, 10)
    //            }
    //            .onDelete { indexSet in
    //                viewModel.instructions.remove(atOffsets: indexSet)
    //                updateInstructionSteps()
    //            }
    //            .onMove { indices, newOffset in
    //                viewModel.instructions.move(fromOffsets: indices, toOffset: newOffset)
    //                updateInstructionSteps()
    //            }
    //
    //            // *************** New Instructions ***************
    //            HStack {
    //                TextField("New Instruction", text: $newInstruction.description)
    //
    //                Button(action: {
    //                    if !newInstruction.description.isEmpty {
    //                        let nextIndex = viewModel.instructions.count + 1
    //                        newInstruction.step = nextIndex
    //                        viewModel.instructions.append(newInstruction)
    //                        newInstruction = Instruction(step: 0, description: "")
    //                    }
    //                }) {
    //                    Image(systemName: "plus.circle.fill")
    //                        .font(.title2)
    //                }
    //            }
    //            .padding(.top, 10)
    //        }
    //    }
    
    
    var actionButtons: some View {
        // MARK: - Save / Delete Buttons
        Section {
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
            }
            
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
        } // end of Section
    }
    
    // MARK: - Helper Functions
    func updateInstructionSteps() {
        for (index, _) in viewModel.instructions.enumerated() {
            viewModel.instructions[index].step = index + 1
        }
    }
}

#Preview {
    RecipeEditorView(isNewRecipe: true, recipe: .constant(MockData.shared.recipe[0]))
}
