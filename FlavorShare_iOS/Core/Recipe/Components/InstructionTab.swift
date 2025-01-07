//
//  InstructionTab.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct InstructionTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .bottom) {
                Text("Instructions")
                    .font(.title)
                    .padding(.bottom)
                
                Spacer()
                
                NavigationLink(destination: CookingModeView(recipe: viewModel.recipe!, selectedServings: viewModel.selectedServings)) {
//                NavigationLink(destination: MealPlanningView()) {
                    Text("Cooking Mode")
                        .font(.body)
                        .padding(.bottom, 20)
                }
            }
            
            if let recipe = viewModel.recipe {
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    HStack (alignment: .top) {
                        Text("\(index + 1).")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        VStack (alignment: .leading) {
                            Text("\(recipe.instructions[index].description)")
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom)
                            
                            let ingredients = RecipeFunctions.getInstructionIngredients(recipe: recipe, instruction: recipe.instructions[index])
                            ForEach(ingredients, id: \.self) { ingredient in
                                HStack {
                                    Text(ingredient.name)
                                    
                                    Spacer()
                                    
                                    if let quantity = ingredient.quantity {
                                        let adjustedQuantity = RecipeFunctions.getQuantity(
                                            recipe: recipe,
                                            selectedServings: viewModel.selectedServings,
                                            quantity: quantity
                                        )
                                        
                                        Text(adjustedQuantity.truncatingRemainder(dividingBy: 1) == 0
                                             ? String(format: "%.0f", adjustedQuantity) // For round numbers, show no decimals
                                             : String(format: "%.1f", adjustedQuantity) // For decimal numbers, show one decimal
                                        )
                                        
                                        if let unit = ingredient.unit {
                                            Text(adjustedQuantity == 1 ? "\(unit)" : "\(unit)s")
                                        }
                                    }
                                }
                                .font(.footnote)
                                .padding(.horizontal)
                                
                            }
                        }
                    }
                    .padding(.top, 5)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.black.opacity(0.5))
                        .clipped()
                }
            }
        }
    }
}

