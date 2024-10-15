//
//  RecipeTile.swift
//  FlavorShare
//
//  Created by Benjamin Lefebvre on 2024-02-29.
//

import SwiftUI
import Kingfisher

// MARK: RECIPE TILE SIZES ENUM
enum RecipeSquareSizes {
    case profile
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .profile:
            return UIScreen.main.bounds.width / 2.3
        case .small:
            return UIScreen.main.bounds.width / 3
        case .medium:
            return UIScreen.main.bounds.width / 2
        case .large:
            return .infinity
        }
    }
}

struct RecipeSquare: View {
    // MARK: VARIABLES
    let recipe: Recipe
    let size: RecipeSquareSizes
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // MARK: BACKGROUND IMAGE
            RemoteImageView(fileName: recipe.imageURL, width: size.dimension, height: size.dimension * 1.3)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(25)
                .clipped()
                .shadow(radius: 3)
            
            // MARK: SHADOW OVERLAY
            LinearGradient(
                gradient: .init(
                    colors: [.black.opacity(1), .clear]
                ),
                startPoint: .bottom,
                endPoint: .top)
            .cornerRadius(25)
            .clipped()
            
            // MARK: RECIPE INFO
            VStack (alignment: .center, spacing: 10) {
                Spacer()
                
                // TITLE
                Text(recipe.title)
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                // TYPE & COOK TIME
                HStack {
                    
                    Text("\(recipe.type) | \(recipe.cookTime) min")
//
//                    Text("|")
//                    
//                    Text(" \(recipe.cookTime) min.")
//    
                } // HStack
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                
                
                // Rating
                //                Text("⭐️ \(recipe.)")
                //                    .font(.footnote)
                //                    .fontWeight(.bold)
                //                    .foregroundStyle(.white)
                
                
            } // VStack
            .padding(.bottom)
            .padding(.horizontal, 5)
            
        } // ZStack
        .frame(width: size.dimension, height: size.dimension, alignment: .leading)
        .multilineTextAlignment(.leading)
        .shadow(radius: 3)
    }
}

#Preview {
    RecipeSquare(recipe: MockData.shared.recipe[0], size: .profile)
}
