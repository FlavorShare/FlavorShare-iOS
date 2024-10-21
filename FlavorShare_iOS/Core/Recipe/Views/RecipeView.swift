//
//  RecipeView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-12.
//

import SwiftUI

struct RecipeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: RecipeViewModel
    @State var viewDetails = "Ingredients"
    @State private var selectedServings: Int
    
    init (recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeViewModel(recipe: recipe))
        _selectedServings = State(initialValue: recipe.servings)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if let recipe = viewModel.recipe {
                BackgroundView(imageURL: recipe.imageURL)
                
                ScrollView {
                    VStack {
                        RecipeImageView(imageURL: recipe.imageURL)
                        //                        RecipeHeader(recipe: recipe, viewModel: $viewModel)
                        //                            .padding(.top, -(UIScreen.main.bounds.height / 9))
                        VStack {
                            ZStack (alignment: .bottom) {
                                VStack (alignment: .center) {
                                    // Recipe Title
                                    Text(recipe.title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                        .padding(.bottom, 2)
                                    
                                    //                                    // Recipe Details
                                    //                                    Text("\(recipe.type) | Serving \(recipe.servings) | \(recipe.cookTime) minutes")
                                    //                                        .padding(.bottom, 5)
                                    // Recipe Details
                                    Text("\(recipe.type) | \(recipe.cookTime) minutes")
                                    
                                    HStack (alignment: .center, spacing: 0) {
                                        Picker("Servings", selection: $selectedServings) {
                                            ForEach(1...20, id: \.self) { serving in
                                                Text("\(serving)").tag(serving)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        Text("Serving\(selectedServings > 1 ? "s" : "")")
                                    }
                                    .tint(.white)
                                    .padding(.bottom, 5)
                                    .padding(.top, -10)
                                    
                                    Text("\(recipe.likes) people liked this recipe")
                                        .font(.footnote)
                                        .padding(.bottom, 5)
                                    
                                    
                                }
                                .padding(.horizontal)
                                .shadow(radius: 3)
                                .onChange(of: selectedServings) {
                                    print(selectedServings)
                                }
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        if viewModel.isLiked {
                                            viewModel.unlikeRecipe()
                                        } else {
                                            viewModel.likeRecipe()
                                        }
                                    }) {
                                        Image(systemName: (viewModel.isLiked ? "heart.fill" : "heart"))
                                    }
                                    .font(.title2)
                                    .padding()
                                }
                            }
                            VStack (alignment: .leading) {
                                // Recipe Owner
                                if let user = recipe.user {
                                    NavigationLink(destination: UserView(user: user)) {
                                        Text("By: \(user.username)")
                                            .font(.footnote)
                                    }
                                }
                                
                                Text("Last Updated: \(recipe.updatedAt.formatted(date: .numeric, time: .omitted))")
                                    .font(.footnote)
                                
                                // Recipe Description
                                Text(recipe.description)
                                    .font(.body)
                                    .padding(.vertical, 5)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundStyle(.white)
                        
                        
                        
                        
                        RecipeDetailsView(recipe: recipe, viewDetails: $viewDetails, selectedServings: $selectedServings)
                            .padding(.horizontal)
                            .padding(.top)
                        Spacer()
                    }
                }
                
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
                    
                    if let user = viewModel.recipe?.user {
                        if user.id == AuthService.shared.currentUser?.id {
                            NavigationLink(destination: RecipeEditorView(isNewRecipe: false, recipe: $viewModel.recipe)) {
                                Text("Edit")
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                    .clipped()
                                    .shadow(radius: 3)
                            }
                        } else {
                            NavigationLink(destination: UserView(user: user)) {
                                // Profile Picture
                                if let imageURL = user.profileImageURL {
                                    if imageURL != "" {
                                        RemoteImageView(fileName: imageURL, width: 50, height: 50)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                            .shadow(radius: 5)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal)
            } // if let recipe
        } // ZStack
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
        .gesture(
            DragGesture().onEnded { value in
                if value.location.x - value.startLocation.x > 150 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
        .onAppear() {
            if viewModel.recipe == nil {
                presentationMode.wrappedValue.dismiss()
            } else {
                viewModel.getUser()
            }
        }
    }
}

struct RecipeImageView: View {
    let imageURL: String
    
    var body: some View {
        RemoteImageView(fileName: imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .black, location: 0.0),
                        .init(color: .black, location: 0.7),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

struct RecipeDetailsView: View {
    var recipe: Recipe
    @Binding var viewDetails: String
    @Binding var selectedServings: Int
    
    var body: some View {
        VStack(alignment: .center) {
            // TabView for Ingredients/Instructions
            HStack (spacing: 0) {
                Button(action: {
                    viewDetails = "Ingredients"
                }) {
                    Text("Ingredients")
                        .foregroundColor(viewDetails == "Ingredients" ? .black : .white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(viewDetails == "Ingredients" ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    viewDetails = "Instructions"
                }) {
                    Text("Instructions")
                        .foregroundColor(viewDetails == "Instructions" ? .black : .white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(viewDetails == "Instructions" ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
            }
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            .clipped()
            
            Group {
                if viewDetails == "Ingredients" {
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .font(.title)
                            .padding(.bottom)
                        
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            HStack {
                                Text(ingredient.name)
                                
                                Spacer()
                                
                                if let quantity = ingredient.quantity {
                                    Text(quantity.truncatingRemainder(dividingBy: 1) == 0
                                         ? String(format: "%.0f", getQuantity(quantity)) // For round numbers, show no decimals
                                         : String(format: "%.1f", getQuantity(quantity)) // For decimal numbers, show one decimal
                                    )
                                    
                                    if let unit = ingredient.unit {
                                        if (quantity == 1) {
                                            Text( "\(unit)")
                                        } else {
                                            Text( "\(unit)s")
                                        }
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
                
                if viewDetails == "Instructions" {
                    VStack(alignment: .leading) {
                        Text("Instructions")
                            .font(.title)
                            .padding(.bottom)
                        
                        ForEach(recipe.instructions.indices, id: \.self) { index in
                            HStack (alignment: .top) {
                                Text("\(index + 1).")
                                    .font(.title)
                                    .foregroundColor(.gray)
                                
                                VStack (alignment: .leading) {
                                    Text("\(recipe.instructions[index].description)")
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom)
                                    
                                    let ingredients = getInstructionIngredients(instruction: recipe.instructions[index])
                                    ForEach(ingredients, id: \.self) { ingredient in
                                        HStack {
                                            Text(ingredient.name)
                                            
                                            Spacer()
                                            
                                            if let quantity = ingredient.quantity {
                                                Text(quantity.truncatingRemainder(dividingBy: 1) == 0
                                                     ? String(format: "%.0f", getQuantity(quantity)) // For round numbers, show no decimals
                                                     : String(format: "%.1f", getQuantity(quantity)) // For decimal numbers, show one decimal
                                                )
                                                
                                                if let unit = ingredient.unit {
                                                    if (quantity == 1) {
                                                        Text( "\(unit)")
                                                    } else {
                                                        Text( "\(unit)s")
                                                    }
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.bottom, 100)
        }
        .foregroundStyle(.white)
        .shadow(radius: 3)
    }
    
    // MARK: - FUNCTIONS
    func getInstructionIngredients(instruction: Instruction) -> [Ingredient] {
        if let listIngredientID = instruction.ingredients {
            return listIngredientID.compactMap { ingredientID in
                return recipe.ingredients.first { $0._id == ingredientID }
            }
        }
        
        return []
    }
    
    func getQuantity(_ quantity: Float) -> Float {
        return quantity * Float(Float(selectedServings) / Float(recipe.servings))

    }
}

#Preview {
    RecipeView(recipe: MockData.shared.recipe[0])
}
