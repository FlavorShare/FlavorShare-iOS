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
                        
                        VStack {
                            ZStack (alignment: .bottom) {
                                VStack (alignment: .center) {
                                    // Recipe Title
                                    Text(recipe.title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                        .padding(.bottom, 2)
                                    
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
                                
                                InteractionButtons()
                                    .environmentObject(viewModel)
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
                        
                        RecipeDetailsView(viewDetails: $viewDetails, selectedServings: $selectedServings)
                            .environmentObject(viewModel)
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

struct InteractionButtons: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                if viewModel.isPlanned {
                    viewModel.removeRecipeFromMealPlan()
                } else {
                    viewModel.addRecipeToMealPlan()
                }
            }) {
                Image(systemName:(viewModel.isPlanned ? "calendar.badge.checkmark" : "calendar.badge.plus") )
                
            }
            .font(.title2)
            .padding(.leading)
            .padding(.vertical)
            
            Button(action: {
                if viewModel.isLiked {
                    viewModel.unlikeRecipe()
                } else {
                    viewModel.likeRecipe()
                }
            }) {
                Image(systemName: (viewModel.isLiked ? "heart.fill" : "heart"))
                    .padding(.bottom, 3)
            }
            .font(.title2)
            .padding(.trailing)
            .padding(.vertical)
        }
    }
}

struct RecipeDetailsView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @Binding var viewDetails: String
    @Binding var selectedServings: Int
    
    var body: some View {
        VStack(alignment: .center) {
            RecipeTabs(viewDetails: $viewDetails)
            
            Group {
                if viewDetails == "Ingredients" {
                    IngredientTab(selectedServings: $selectedServings)
                        .environmentObject(viewModel)
                }
                
                if viewDetails == "Instructions" {
                    InstructionTab(selectedServings: $selectedServings)
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

struct RecipeTabs: View {
    @Binding var viewDetails: String
    
    var body: some View {
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
    }
}

struct IngredientTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @Binding var selectedServings: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title)
                .padding(.bottom)
            
            ForEach(viewModel.recipe!.ingredients, id: \.self) { ingredient in
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
    
    // MARK: - FUNCTIONS
    func getInstructionIngredients(instruction: Instruction) -> [Ingredient] {
        if let listIngredientID = instruction.ingredients {
            return listIngredientID.compactMap { ingredientID in
                return viewModel.recipe!.ingredients.first { $0._id == ingredientID }
            }
        }
        
        return []
    }
    
    func getQuantity(_ quantity: Float) -> Float {
        return quantity * Float(Float(selectedServings) / Float(viewModel.recipe!.servings))
        
    }
}

struct InstructionTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @Binding var selectedServings: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.title)
                .padding(.bottom)
            
            ForEach(viewModel.recipe!.instructions.indices, id: \.self) { index in
                HStack (alignment: .top) {
                    Text("\(index + 1).")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    VStack (alignment: .leading) {
                        Text("\(viewModel.recipe!.instructions[index].description)")
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom)
                        
                        let ingredients = getInstructionIngredients(instruction: viewModel.recipe!.instructions[index])
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
    
    // MARK: - FUNCTIONS
    func getInstructionIngredients(instruction: Instruction) -> [Ingredient] {
        if let listIngredientID = instruction.ingredients {
            return listIngredientID.compactMap { ingredientID in
                return viewModel.recipe!.ingredients.first { $0._id == ingredientID }
            }
        }
        
        return []
    }
    
    func getQuantity(_ quantity: Float) -> Float {
        return quantity * Float(Float(selectedServings) / Float(viewModel.recipe!.servings))
        
    }
}

struct ReviewTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @State private var users: [String: User] = [:]
    
    func fetchUser(for review: Review) {
        viewModel.getUserById(userId: review.ownerId) { fetchedUser in
            if let fetchedUser = fetchedUser {
                users[review.ownerId] = fetchedUser
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Reviews")
                    .font(.title)
                    .padding(.bottom)
                
                Spacer()
                // Rating
            }
            
            
            // TODO: Comment Creation
            // Text input for creating a new comment
            TextField("Add a Comment", text: $viewModel.newComment, prompt: Text("Add a Comment").foregroundColor(.white.opacity(0.5)))
            
            // Button to submit the comment
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.addReview()
                }) {
                    Text("Submit")
                }
            }
            
            if (viewModel.recipe!.reviews == nil || viewModel.recipe!.reviews!.isEmpty) {
                Text("No Reviews Yet")
            } else {
                // TODO: List Reviews
                //                ForEach(viewModel.recipe!.reviews!, id: \.self) { review in
                //                    let user = viewModel.getUserById(userId: review.ownerId)
                //
                //                    HStack {
                //                        // Profile Picture
                //                        if let imageURL = user?.profileImageURL {
                //                            if imageURL != "" {
                //                                RemoteImageView(fileName: imageURL, width: 50, height: 50)
                //                                    .clipShape(Circle())
                //                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                //                                    .shadow(radius: 5)
                //                            }
                //                        }
                //
                //                        VStack {
                //                            HStack {
                //                                // Username
                //                                Text(user?.username ?? "User")
                //                                    .font(.headline)
                //
                //                                Spacer()
                //
                //                                // Rating
                //                                Text("\(review.rating)/5")
                //                                    .font(.headline)
                //                            }
                //
                //
                //                            // Review
                //                            Text(review.comment)
                //                                .font(.body)
                //                        }
                //
                //
                //
                //                    }
                //
                //                    Divider()
                //                        .frame(height: 1)
                //                        .background(Color.black.opacity(0.5))
                //                        .clipped()
                //                }
                //            }
                ForEach(viewModel.recipe!.reviews!, id: \.self) { review in
                    if let user = users[review.ownerId] {
                        HStack (alignment: .top) {
                            // Profile Picture
                            if let imageURL = user.profileImageURL, !imageURL.isEmpty {
                                RemoteImageView(fileName: imageURL, width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .shadow(radius: 3)
                            }
                            
                            VStack (alignment: .leading){
                                HStack {
                                    // Username
                                    Text(user.username)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    // Rating
                                    Text("\(review.rating)/5")
                                        .font(.headline)
                                }
                                
                                // Review
                                Text(review.comment)
                                    .font(.body)
                            }
                            .padding(.leading)
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.black.opacity(0.5))
                            .clipped()
                    } else {
                        // Placeholder view while fetching user information
                        HStack {
                            Text("Loading user...")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("\(review.rating)/5")
                                .font(.headline)
                        }
                        .onAppear {
                            fetchUser(for: review)
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.black.opacity(0.5))
                            .clipped()
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeView(recipe: MockData.shared.recipe[0])
}
