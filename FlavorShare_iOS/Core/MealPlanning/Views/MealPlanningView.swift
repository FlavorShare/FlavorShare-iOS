//
//  Untitled.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-18.
//

import SwiftUI

struct MealPlanningView: View {
    @StateObject var viewModel: MealPlanningViewModel = MealPlanningViewModel()
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack (){
            ZStack {
                // Background Image
                Image("Background")
                    .resizable()
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
                
                BlurView(style: .regular)
                    .frame(width: screenWidth, height: screenHeight)
                
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: screenWidth, height: screenHeight)
                
                ScrollView {
                   
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Meal Planning")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.bottom)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.deleteRecipePlanned()
                            }) {
                                Text("Clear")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(.top, -10)
                            }
                        }
                       
                        // Recipe Lists
                        LazyHStack(spacing: screenWidth / 6) {
                            ForEach(viewModel.RecipePlanned) { recipe in
                                NavigationLink(destination: RecipeView(recipe: recipe)) {
                                    RecipeSquare(recipe: recipe, size: .profile)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        
                        Text("Grocery List (\(viewModel.ingredients.count) items)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.top, screenHeight/10)
                            .padding(.bottom)
                        
                        // Grocery List
                        LazyVStack {
                            ForEach($viewModel.ingredients) { $ingredient in
                                Button(action: {
                                    ingredient.isCompleted?.toggle() // Update directly with the binding
                                }) {
                                    HStack {
                                        // TODO: Bullet
                                        Image(systemName: (ingredient.isCompleted ?? false) ? "checkmark.circle.fill" : "circle")
                                        
                                        Text("\(ingredient.name)")
                                        
                                        Spacer()
                                        
                                        if let quantity = ingredient.quantity {
                                            Text(quantity.truncatingRemainder(dividingBy: 1) == 0
                                                 ? String(format: "%.0f", quantity)
                                                 : String(format: "%.1f", quantity)
                                            )
                                            
                                            if let unit = ingredient.unit {
                                                Text(quantity == 1 ? "\(unit)" : "\(unit)s")
                                            }
                                        }
                                    }
                                    .font(.body)
                                    .foregroundStyle(.white)
                                }
                                
                                Divider()
                                    .frame(width: screenWidth / 1.1, height: 1)
                                    .background(Color.white)
                            }
                        } // LazyVStack
                        
                        Spacer()
                    } // VStack
                    .padding(.top, screenHeight/10)
                    .padding(.horizontal)
                    
                } // ScrollView
                .refreshable {
                    viewModel.getRecipePlanned()
                }
                .onAppear() {
                    viewModel.getRecipePlanned()
                }
                
            }// ZStack
            .ignoresSafeArea(.container, edges: .top)
        }// NavigationStack
        
    }
        
}

#Preview {
    MealPlanningView()
}
