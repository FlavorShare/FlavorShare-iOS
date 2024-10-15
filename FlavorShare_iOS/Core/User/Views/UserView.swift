//
//  UserView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-01.
//

import SwiftUI

struct UserView: View {
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
                            Spacer()
                            Button(action: {
                                let _ = AuthService.shared.signOut()
                            }) {
                                Text("Sign Out")
                                    .foregroundStyle(.white)
                            }
                            .padding(.top, 60)
                        }
                        .padding()
                        
                        
                        // Profile Picture
                        ZStack {
                            RemoteImageView(fileName: viewModel.user.profileImageURL ?? "Image", width: screenWidth/4, height: screenWidth/4)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 5)
                        }
                        
                        ZStack (alignment: .top) {
                            VStack {
                                // Username
                                Text(viewModel.user.username)
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .colorInvert()
                                    .shadow(radius: 5)
                                
                                // User Bio
                                Text(viewModel.user.bio ?? "Bio")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .colorInvert()
                                    .shadow(radius: 5)
                            }
                            
                            HStack {
                                Spacer()
                                NavigationLink(destination: UserEditView(user: $viewModel.user)) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                        .padding(.top, 8)
                                        .padding(.trailing)
                                        .font(.title)
                                        .shadow(radius: 5)
                                }
                            }
                        }
                        .padding(.vertical, screenHeight/20)
                        
                        
                        VStack (alignment: .leading) {
                            // User Recipes
                            HStack {
                                Text("Recipes")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .colorInvert()
                                    .shadow(radius: 5)
                                
                                Spacer()
                                NavigationLink(destination: RecipeEditorView(isNewRecipe: true)) {
                                    Image(systemName: "plus")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                            }
                            .padding(.horizontal)

                            
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
                            .padding(.bottom, screenHeight / 5)
                        }
                        Spacer()
                    } // VStack end
                } // ScrollView end
                .ignoresSafeArea(.all)
            }
        } // Navigation
    } // Body end
} // Struct end


#Preview {
    UserView(user: MockData.shared.user)
}
