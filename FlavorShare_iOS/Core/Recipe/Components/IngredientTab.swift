//
//  IngredientTab.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct IngredientTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title)
                .padding(.bottom)
            
            if let recipe = viewModel.recipe {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
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
                            // TODO: FIX THE FRACTIONAL CONVERSION currently having issues with the numbers like 0.1666666666666667 and 0.3333333333333333 giving off fractions like 17/100 and 33/100 instead of 1/6 and 1/3 respectively
                            // Text(decimalToFraction(Double(adjustedQuantity)))
                            
                            if let unit = ingredient.unit {
                                Text(quantity == 1 ? "\(unit)" : "\(Unit.measurementsPlural[unit] ?? "\(unit)")")
                            }
                        }
                    }
                    .padding(.top, 5)
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.black.opacity(0.5))
                }
            }
        }
    }
}
