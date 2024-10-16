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
    
    init (recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeViewModel(recipe: recipe))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView(imageURL: viewModel.recipe.imageURL)
            
            ScrollView {
                VStack {
                    RecipeImageView(imageURL: viewModel.recipe.imageURL)
                    RecipeHeader(recipe: viewModel.recipe)
                        .padding(.top, -(UIScreen.main.bounds.height / 9))
                    RecipeDetailsView(recipe: viewModel.recipe, viewDetails: $viewDetails)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
            }
            
            HStack {
                // Back button to go back in navigation stack
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                        Text("Back")
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .clipped()
                    .shadow(radius: 3)
                }
                
                Spacer()
                
                NavigationLink(destination: RecipeEditorView(isNewRecipe: false, recipe: Binding(get: { Optional(viewModel.recipe) }, set: { viewModel.recipe = $0! }))) {
                    Text("Edit")
                        .foregroundStyle(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .clipped()
                        .shadow(radius: 3)
                }
                
            }
            .padding(.top, 60)
            .padding(.horizontal)
        }
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
    }
}

struct BackgroundView: View {
    let imageURL: String
    
    var body: some View {
        ZStack {
            RemoteImageView(fileName: imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .blur(radius: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            BlurView(style: .regular)
                .ignoresSafeArea(.all)
            Rectangle()
                .fill(Color.black.opacity(0.4))
                .ignoresSafeArea(.all)
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

struct RecipeHeader: View {
    var recipe: Recipe
    
    var body: some View {
        VStack (alignment: .center) {
            // Recipe Title
            Text(recipe.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom, 2)
            
            // Recipe Details
            Text("\(recipe.type) | Serving \(recipe.servings) | \(recipe.cookTime) minutes")
                .padding(.bottom, 5)
            
//            Text("\(recipe.likes) people liked this recipe")
//                .font(.footnote)
//                .padding(.bottom, 5)
            
            VStack (alignment: .leading) {
                // Recipe Owner
                if let user = recipe.user {
                    Text("By: \(user.username)")
                        .font(.footnote)
                }
                
                Text("Last Updated: \(recipe.updatedAt.formatted(date: .numeric, time: .omitted))")
                    .font(.footnote)
                
                // Recipe Description
                Text(recipe.description)
                    .font(.body)
                    .padding(.vertical, 5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
        .shadow(radius: 3)
    }
    
}


struct RecipeDetailsView: View {
    var recipe: Recipe
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
                                    Text("\(quantity)")
                                    
                                    if (quantity == 1) {
                                        Text(ingredient.unit != nil ? "\(ingredient.unit!)" : "unit")
                                    } else {
                                        Text(ingredient.unit != nil ? "\(ingredient.unit!)s" : "units")
                                        
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
                                    
                                    ForEach(recipe.instructions[index].ingredients ?? [], id: \.self) { ingredient in
                                        HStack {
                                            if let quantity = ingredient.quantity {
                                                Text("\(quantity)")
                                                    .font(.footnote)
                                                if (quantity == 1) {
                                                    Text(ingredient.unit != nil ? "\(ingredient.unit!)" : "unit")
                                                        .font(.footnote)
                                                } else {
                                                    Text(ingredient.unit != nil ? "\(ingredient.unit!)s" : "units")
                                                        .font(.footnote)
                                                }
                                            }
                                            
                                            Text(ingredient.name)
                                                .font(.footnote)
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.bottom, 100)
        }
        .foregroundStyle(.white)
        .shadow(radius: 3)
    }
}

#Preview {
    RecipeView(recipe: MockData.shared.recipe[0])
}
