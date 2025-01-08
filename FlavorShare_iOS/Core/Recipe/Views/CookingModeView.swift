//
//  CookingModeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct CookingModeView: View {
    @StateObject var viewModel: CookingModeViewModel
    @State var selectedServings: Int
    @State private var currentStep: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    init(recipe: Recipe, selectedServings: Int = 1) {
        _viewModel = StateObject(wrappedValue: CookingModeViewModel(recipe: recipe))
        self.selectedServings = selectedServings
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView(imageURL: viewModel.recipe.imageURL)
            
            VStack {
                HStack (alignment: .top) {
                    // Back button to go back in navigation stack
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .clipped()
                    }
                    
                    Spacer()
                } // end of HStack
                .padding(.bottom)
                
                if (currentStep < viewModel.recipe.instructions.count) {
                    // Display current instruction
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Step \(currentStep + 1) of \(viewModel.recipe.instructions.count)")
                                .font(.headline)
                            
                            Spacer()
                        }
                        
                        let instruction = viewModel.recipe.instructions[currentStep]
                        Text(instruction.description)
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                        
                        let ingredients = getInstructionIngredients(instruction: instruction)
                        if !ingredients.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Ingredients:")
                                    .font(.headline)
                                    .padding(.top)
                                ForEach(ingredients, id: \.self) { ingredient in
                                    HStack {
                                        Text(ingredient.name)
                                        Spacer()
                                        if let quantity = ingredient.quantity {
                                            Text(quantity.truncatingRemainder(dividingBy: 1) == 0
                                                 ? String(format: "%.0f", getQuantity(quantity))
                                                 : String(format: "%.1f", getQuantity(quantity)))
                                            if let unit = ingredient.unit {
                                                Text(quantity == 1 ? "\(unit)" : "\(Unit.measurementsPlural[unit] ?? "\(unit)")")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
                else if (currentStep == viewModel.recipe.instructions.count) {
                    Text("Your recipe is complete! Time to enjoy your meal!")
                        .font(.title)
                        .padding()
                }
                
                
                Spacer()
                
                // Navigation buttons
                HStack {
                    if (currentStep != 0) {
                        Button(action: {
                            if currentStep > 0 { currentStep -= 1 }
                        }) {
                            Text("Previous")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .clipped()
                        }
                    }
                    
                    Spacer()
                    
                    if (currentStep != viewModel.recipe.instructions.count) {
                        Button(action: {
                            if currentStep < viewModel.recipe.instructions.count { currentStep += 1 }
                        }) {
                            Text("Next")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .clipped()
                        }
                    }
                    
                    if (currentStep == viewModel.recipe.instructions.count) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Done")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                                .clipped()
                        }
                    }
                }
            }
            .padding(.top, 60)
            .padding(.bottom, 100)
            .padding(.horizontal)
            .shadow(radius: 3)
            .foregroundColor(.white)
        }
        .background(.gray)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture().onEnded { value in
                let horizontalAmount = value.translation.width
                if horizontalAmount > 150 {
                    // Swipe right
                    if currentStep == 0 {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        currentStep -= 1
                    }
                } else if horizontalAmount < -150 {
                    // Swipe left
                    if currentStep == viewModel.recipe.instructions.count {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        currentStep += 1
                    }
                }
            }
        )
    }
    
    // MARK: - FUNCTIONS
    func getInstructionIngredients(instruction: Instruction) -> [Ingredient] {
        if let listIngredientID = instruction.ingredients {
            return listIngredientID.compactMap { ingredientID in
                return viewModel.recipe.ingredients.first { $0._id == ingredientID }
            }
        }
        return []
    }
    
    func getQuantity(_ quantity: Float) -> Float {
        return quantity * Float(Float(selectedServings) / Float(viewModel.recipe.servings))
    }
}

#Preview {
    CookingModeView(recipe: MockData.shared.recipe[0])
}
