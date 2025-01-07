//
//  ReviewTab.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct ReviewTab: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    @State private var users: [String: User] = [:]
    
    func fetchUser(for review: Review) {
        viewModel.getUserById(userId: review.ownerId) { fetchedUser in
            if let fetchedUser = fetchedUser {
                DispatchQueue.main.async {
                    users[review.ownerId] = fetchedUser
                }
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
            }
            
            VStack (spacing: 10) {
                // MARK: REVIEW CREATION
                if (!viewModel.userHasAlreadyReviewed) {
                    HStack {
                        // Rating
                        HStack {
                            ForEach(1..<6) { index in
                                Button(action: {
                                    viewModel.rating = index
                                }) {
                                    Image(systemName: viewModel.rating >= index ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    
                    TextField("Add a Comment", text: $viewModel.newComment, prompt: Text("Add a Comment").foregroundColor(.white.opacity(0.5)))
                    
                    // Button to submit the comment
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            viewModel.addReview()
                        }) {
                            Text("Submit Review")
                        }
                    }
                } else if (viewModel.userHasAlreadyReviewed && viewModel.hideCommentField) {
                    // Button to submit the comment
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            viewModel.hideCommentField = false
                        }) {
                            Text("Edit Review")
                        }
                    }
                } else {
                    HStack {
                        // Rating
                        HStack {
                            ForEach(1..<6) { index in
                                Button(action: {
                                    viewModel.rating = index
                                }) {
                                    Image(systemName: viewModel.rating >= index ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    TextField("Update existing Comment", text: $viewModel.newComment, prompt: Text("Update existing Comment").foregroundColor(.white.opacity(0.5)))
                    
                    // Button to submit the comment
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            viewModel.updateReview()
                        }) {
                            Text("Update Review")
                        }
                    }
                }
            }
            
            VStack {
                // MARK: LIST OF REVIEWS
                if let reviews = viewModel.recipe?.reviews, !reviews.isEmpty {
                    ForEach(reviews, id: \.id) { review in
                        if let user = users[review.ownerId] {
                            HStack(alignment: .top) {
                                // Profile Picture
                                if let imageURL = user.profileImageURL, !imageURL.isEmpty {
                                    RemoteImageView(fileName: imageURL, width: 40, height: 40)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                        .shadow(radius: 3)
                                }
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(user.username).font(.headline)
                                        Spacer()
                                        Text("\(review.rating)/5").font(.headline)
                                    }
                                    
                                    Text(review.comment).font(.body)
                                }
                                .padding(.leading)
                            }
                            Divider().frame(height: 1).background(Color.black.opacity(0.5)).clipped()
                        } else {
                            HStack {
                                Text("Loading user...").font(.headline)
                                Spacer()
                                Text("\(review.rating)/5").font(.headline)
                            }
                            .onAppear {
                                fetchUser(for: review)
                            }
                            Divider().frame(height: 1).background(Color.black.opacity(0.5)).clipped()
                        }
                    }
                } else {
                    Text("No Reviews Yet")
                }
            } // End of VStack
            .padding(.top)
        }
    }
}
