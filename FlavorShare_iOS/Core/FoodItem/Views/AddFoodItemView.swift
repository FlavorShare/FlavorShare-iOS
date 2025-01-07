//
//  AddFoodItemView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-04.
//

import SwiftUI

struct AddFoodItemView: View {
    @StateObject var viewModel: AddFoodItemViewModel = AddFoodItemViewModel()
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack (){
            
            ZStack {
                BackgroundView(imageURL: nil)
                
                VStack (alignment: .leading) {
                    Text("Add a Food Item")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom)
                        .shadow(radius: 5)
                    
                    TextField("Food Names", text: $viewModel.names, prompt: Text("Food Names").foregroundColor(.white.opacity(0.5)), axis: .vertical)
                        .padding(.top, 5)
                    
                    TextField("Category", text: $viewModel.category, prompt: Text("Category").foregroundColor(.white.opacity(0.5)), axis: .vertical)
                        .padding(.top, 5)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            viewModel.addFoodItems()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                } // VStack
                .padding(.horizontal)
                .padding(.top, screenHeight/10)
                .foregroundStyle(.white)
                
            } // ZStack
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    AddFoodItemView()
}
