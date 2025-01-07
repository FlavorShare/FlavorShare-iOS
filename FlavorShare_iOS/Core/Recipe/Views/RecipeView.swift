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
    
    init (recipe: Recipe, servings: Int? = nil) {
        _viewModel = StateObject(wrappedValue: RecipeViewModel(recipe: recipe, servings: servings))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if let recipe = viewModel.recipe {
                BackgroundView(imageURL: recipe.imageURL)
                
                ScrollView {
                    VStack {
                        RemoteImageView(fileName: recipe.imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
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
                                        Picker("Servings", selection: $viewModel.selectedServings) {
                                            ForEach(1...20, id: \.self) { serving in
                                                Text("\(serving)").tag(serving)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        Text("Serving\(viewModel.selectedServings > 1 ? "s" : "")")
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
                        
                        RecipeDetailsView(viewDetails: $viewDetails)
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
            
            // MEAL PLANNING CONFIRMATION
            if viewModel.showMealPlanningConfirmation {
                VStack {
                    VStack (spacing: 20) {
                        Text("Please Confirm the Number of Servings.")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        
                        HStack (alignment: .center, spacing: 0) {
                            Picker("Servings", selection: $viewModel.selectedServings) {
                                ForEach(1...20, id: \.self) { serving in
                                    Text("\(serving)").tag(serving)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            Text("Serving\(viewModel.selectedServings > 1 ? "s" : "")")
                        }
                        .tint(.white)
                        
                        Text("Before confirming, note the grocery list will be reset and the new ingredients will be added.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                        
                        HStack (spacing: 20) {
                            Button(action: {
                                viewModel.showMealPlanningConfirmation = false
                            }) {
                                Text("Cancel")
                                    .font(.body)
                            }
                            .buttonStyle(.bordered)
                            
                            Button(action: {
                                viewModel.addRecipeToMealPlan()
                                viewModel.showMealPlanningConfirmation = false
                            }) {
                                Text("Confirm")
                                    .font(.body)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .padding()
//                    .padding(.vertical, 30)
                    .foregroundStyle(.white)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .clipped()
                    .shadow(radius: 10)
                }
                .padding(.top, UIScreen.main.bounds.height/3)
            }
            
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

#Preview {
    RecipeView(recipe: MockData.shared.recipe[0])
}
