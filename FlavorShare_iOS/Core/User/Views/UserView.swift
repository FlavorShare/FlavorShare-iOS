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
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink(destination: UserEditView(user: $viewModel.user)) {
                        Text("Edit")
                    }
                    
                    // User Image
                    RemoteImageView(fileName: viewModel.user.profileImageURL ?? "Image")
                        .frame(width: 50, height: 50)
                        .clipped()
                    
                    // User Name
                    Text(viewModel.user.username)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // User First Name
                    Text(viewModel.user.firstName)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // User Bio
                    Text(viewModel.user.bio ?? "Bio")
                        .font(.body)
                        .padding(.horizontal)
                    
                    // User Recipes
                    Text("Recipes")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Recipe Lists
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe)) {
                            HStack {
                                RemoteImageView(fileName: recipe.imageURL)
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                
                                VStack(alignment: .leading) {
                                    Text(recipe.title)
                                        .font(.headline)
                                    Text(recipe.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserEditView(user: $viewModel.user)) {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

#Preview {
    UserView(user: MockData.shared.user)
}
