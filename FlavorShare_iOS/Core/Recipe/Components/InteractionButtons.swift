//
//  InteractionButtons.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-29.
//

import SwiftUI

struct InteractionButtons: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                if viewModel.isPlanned {
                    viewModel.removeRecipeFromMealPlan()
                } else {
//                    viewModel.addRecipeToMealPlan()
                    viewModel.showMealPlanningConfirmation = true
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
