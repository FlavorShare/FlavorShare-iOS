//
//  RecipeTabs.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct RecipeDetailsView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @Binding var viewDetails: String
    
    var body: some View {
        VStack(alignment: .center) {
            // TabView for Ingredients/Instructions
            HStack (spacing: 0) {
                Button(action: {
                    viewDetails = "Ingredients"
                }) {
                    Text("Ingredients")
                        .foregroundColor(viewDetails == "Ingredients" ? .black : .white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(viewDetails == "Ingredients" ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewDetails = "Instructions"
                }) {
                    Text("Instructions")
                        .foregroundColor(viewDetails == "Instructions" ? .black : .white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(viewDetails == "Instructions" ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewDetails = "Reviews"
                }) {
                    Text("Reviews")
                        .foregroundColor(viewDetails == "Reviews" ? .black : .white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(viewDetails == "Reviews" ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
            }
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .clipped()
            
            Group {
                if viewDetails == "Ingredients" {
                    IngredientTab()
                        .environmentObject(viewModel)
                }
                
                if viewDetails == "Instructions" {
                    InstructionTab()
                        .environmentObject(viewModel)
                }
                
                if viewDetails == "Reviews" {
                    ReviewTab()
                        .environmentObject(viewModel)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.bottom, 100)
        }
        .foregroundStyle(.white)
        .shadow(radius: 3)
    }
}

