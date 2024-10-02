//
//  UserView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-01.
//

import SwiftUI

struct UserView: View {
    @State var user: User
    @State var recipes: [Recipe]
    
    init(user: User, recipes: [Recipe]) {
        self.user = user
        self.recipes = recipes
        print(recipes)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // User Image
                RemoteImageView(fileName: user.profileImageURL ?? "Image")
                    .frame(width: 50, height: 50)
                    .clipped()
                
                // User Name
                Text(user.username)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // User Bio
                Text(user.bio ?? "Bio")
                    .font(.body)
                    .padding(.horizontal)
                
                // User Recipes
                Text("Recipes")
                    .font(.headline)
                    .padding(.horizontal)
                
                // Recipe Lists
                List(recipes) { recipe in
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
                Button("Edit") {
                    // Edit user profile
                }
            }
        }
    }
}

#Preview {
    UserView(user: MockData.shared.user, recipes: MockData.shared.recipe)
}
