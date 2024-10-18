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
                                    
                                    // Recipe Details
                                    Text("\(recipe.type) | Serving \(recipe.servings) | \(recipe.cookTime) minutes")
                                        .padding(.bottom, 5)
                                    
                                    Text("\(recipe.likes) people liked this recipe")
                                        .font(.footnote)
                                        .padding(.bottom, 5)
                                    
                                    
                                }
                                .padding(.horizontal)
                                .shadow(radius: 3)
                                
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
                        
                        
                        
                        
                        RecipeDetailsView(recipe: recipe, viewDetails: $viewDetails)
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
