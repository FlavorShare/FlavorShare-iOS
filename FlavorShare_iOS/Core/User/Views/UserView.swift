//
//  UserView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-01.
//

import SwiftUI

struct UserView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresentedAsChild = false
    
    @StateObject private var viewModel: UserViewModel
    
    init(user: User) {
        _viewModel = StateObject(wrappedValue: UserViewModel(user: user))
    }
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Image
                RemoteImageView(fileName: viewModel.user.profileImageURL ?? "Image", width: screenWidth, height: screenHeight)
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea(.all)
                
                BlurView(style: .regular)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        HStack {
                            if isPresentedAsChild {
                                // Show custom back button only if presented as a child
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
                            }
                            
                            Spacer()
                            
                            if viewModel.user.id == AuthService.shared.currentUser?.id {
                                Button(action: {
                                    let _ = AuthService.shared.signOut()
                                }) {
                                    Text("Sign Out")
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.top, 60)
                        .padding(.horizontal)
                        
                        
                        // Profile Picture
                        if let imageURL = viewModel.user.profileImageURL {
                            if imageURL != "" {
                                RemoteImageView(fileName: imageURL, width: screenWidth/4, height: screenWidth/4)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                    .shadow(radius: 5)
                            }
                        }
                        
                        ZStack (alignment: .top) {
                            VStack {
                                // Username
                                Text(viewModel.user.username)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .shadow(radius: 5)
                                
                                // User Bio
                                Text(viewModel.user.bio ?? "Bio")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .shadow(radius: 5)
                                    .padding(.horizontal)
                            }
                            
                            HStack {
                                Spacer()
                                
                                if viewModel.user.id == AuthService.shared.currentUser?.id {
                                    NavigationLink(destination: UserEditView(user: $viewModel.user)) {
                                        Image(systemName: "pencil")
                                            .padding(.top, 8)
                                            .padding(.trailing)
                                            .font(.title)
                                            .shadow(radius: 5)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 30)
                        .foregroundColor(.white)
                        
                        VStack (alignment: .leading) {
                            // User Recipes
                            HStack {
                                Text("Recipes")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                
                                Spacer()
                                
                                if viewModel.user.id == AuthService.shared.currentUser?.id {
                                    NavigationLink(destination: RecipeEditorView(isNewRecipe: true)) {
                                        Image(systemName: "plus")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .shadow(radius: 5)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            let columns = [
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible(), spacing: 10)
                            ]
                            
                            // Recipe Lists
                            LazyVGrid(columns: columns, spacing: screenWidth / 6) {
                                ForEach(viewModel.recipes) { recipe in
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        RecipeSquare(recipe: recipe, size: .profile)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                        Spacer()
                    } // VStack end
                    .padding(.bottom, 150)
                } // ScrollView end
                .refreshable {
                    viewModel.fetchRecipes()
                    
                    // TODO: FIND A WAY TO REFRESH FULL PROFILE (IMAGE AND ALL ON REFRESH)
                }
                .onAppear() {
                    isPresentedAsChild = presentationMode.wrappedValue.isPresented
                    viewModel.fetchRecipes()
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
        } // Navigation
    } // Body end
} // Struct end


#Preview {
    UserView(user: MockData.shared.user)
}
