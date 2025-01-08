//
//  Untitled.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-12-18.
//

import SwiftUI

struct MealPlanningView: View {
    @StateObject var viewModel: MealPlanningViewModel = MealPlanningViewModel()
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack (){
            ZStack {
                BackgroundView(imageURL: nil)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Meal Planning")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.bottom)
                                .shadow(radius: 5)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.deleteRecipePlanned()
                            }) {
                                Text("Clear")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 20)
                                    .shadow(radius: 3)
                            }
                        }
                        
                        // Recipe Lists
                        let columns = [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10)
                        ]
                        
                        // Recipe Lists
                        LazyVGrid(columns: columns, spacing: screenWidth / 6) {
                            ForEach(viewModel.RecipePlanned) { recipe in
                                
                                let servings: Int = viewModel.getNumberOfServings(for: recipe)
                                
                                NavigationLink(destination: RecipeView(recipe: recipe, servings: servings)) {
                                    
                                    
                                    
                                    RecipeSquare(recipe: recipe, size: .profile, servings: servings)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                        
                        
                        HStack {
                            Text("Grocery List (\(viewModel.quantityItems) \(viewModel.quantityItems == 1 ? "item" : "items"))")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.top, 50)
                                .padding(.bottom)
                                .shadow(radius: 5)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.categorizedGroceryItems.removeAll()
                                viewModel.updateMealPlan()
                            }) {
                                Text("Reset")
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 20)
                                    .shadow(radius: 3)
                            }
                        }
                        
                        // Grocery List
                        LazyVStack(alignment: .leading) {
                            ForEach(categories(), id: \.self) { category in
                                // If there is more than 1 item in the category
                                let isSingleItem = viewModel.categorizedGroceryItems[category]?.count ?? 0 == 1
                                
                                Text(isSingleItem ? category.capitalized : category.capitalized + "s")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 5)
                                    .shadow(radius: 5)
                                
                                GroceryListItems(category: category)
                                    .environmentObject(viewModel)
                                    .padding(.bottom, 25)
                                
                            }
                        } // LazyVStack
                        
                        Spacer()
                    } // VStack
                    .padding(.top, screenHeight/10)
                    .padding(.horizontal)
                    .padding(.bottom, 150)
                    
                } // ScrollView
                .refreshable {
                    viewModel.updateMealPlan()
                }
                .onAppear() {
                    viewModel.updateMealPlan()
                }
                
            }// ZStack
            .ignoresSafeArea(.container, edges: .top)
            .gesture(
                TapGesture()
                    .onEnded {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }// NavigationStack
        
    }
    
    private func categories() -> [String] {
        var categories: [String] = Array(viewModel.categorizedGroceryItems.keys)
        
        // move "others" to the end
        if let index = categories.firstIndex(where: { $0.lowercased() == "other" }) {
            categories.append(categories.remove(at: index))
        }
        
        // move fruits to the front
        if let index = categories.firstIndex(where: { $0.lowercased() == "fruit" }) {
            categories.insert(categories.remove(at: index), at: 0)
        }
        
        // move vegetables to the front
        if let index = categories.firstIndex(where: { $0.lowercased() == "vegetable" }) {
            categories.insert(categories.remove(at: index), at: 0)
        }
        
        return categories
    }
}

struct GroceryListItems: View {
    @EnvironmentObject var viewModel: MealPlanningViewModel
    
    var category: String
    
    @State private var newItemName: String = ""
    @State private var newItemQuantity: String = ""
    @State private var newItemUnit: String = ""
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.categorizedGroceryItems[category] ?? [], id: \.id) { foodItem in
                Button(action: {
                    if let index = viewModel.categorizedGroceryItems[category]?.firstIndex(where: { $0.id == foodItem.id }) {
                        viewModel.categorizedGroceryItems[category]?[index].isCompleted?.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: (foodItem.isCompleted ?? false) ? "checkmark.circle.fill" : "circle")
                        
                        Text("\(foodItem.name.capitalized)")
                        
                        Spacer()
                        
                        if let quantity = foodItem.quantity {
                            Text(quantity.truncatingRemainder(dividingBy: 1) == 0
                                 ? String(format: "%.0f", quantity)
                                 : String(format: "%.1f", quantity)
                            )
                            
                            if let unit = foodItem.unit {
                                Text(quantity == 1 ? "\(unit)" : "\(Unit.measurementsPlural[unit] ?? "\(unit)")")
                            }
                        }
                    }
                    .font(.body)
                    .foregroundStyle(.white)
                }
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .background(Color.white)
                    .padding(.bottom, 5)
            }
            
            // Allow user to add new items
            HStack {
                TextField("New item name", text: $newItemName, prompt: Text("New item name").foregroundColor(.white.opacity(0.5)))
                    .padding(.trailing, 5)
                
                TextField("Quantity", text: $newItemQuantity, prompt: Text("Quantity").foregroundColor(.white.opacity(0.5)))
                    .keyboardType(.decimalPad)
                    .padding(.trailing, 5)
                
                Picker("Unit", selection: $newItemUnit) {
                    ForEach(Unit.measurementsSingular, id: \.self) { unit in
                        Text(unit).tag(unit)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .tint(.white)
                .padding(.bottom, 5)
                
                Button(action: {
                    guard !newItemName.isEmpty else { return }
                    
                    // Creating new Food Item
                    let newFoodItem = FoodItem(
                        name: newItemName,
                        category: category,
                        quantity: Float(newItemQuantity) ?? nil,
                        unit: newItemUnit.isEmpty ? nil : newItemUnit
                    )
                    
                    // Adding to the categorizedGroceryItems based on if existing category exists
                    if viewModel.categorizedGroceryItems[category] != nil {
                        
                        if (viewModel.categorizedGroceryItems[category]?.contains(where: { $0.name == newFoodItem.name && $0.unit == newFoodItem.unit })) ?? false {
                            if let index = viewModel.categorizedGroceryItems[category]?.firstIndex(where: { $0.id == newFoodItem.id && $0.unit == newFoodItem.unit }) {
                                viewModel.categorizedGroceryItems[category]?[index].quantity! += newFoodItem.quantity!
                            }
                            return
                            
                        } else {
                            viewModel.categorizedGroceryItems[category]?.append(newFoodItem)
                        }
                        
                    } else {
                        viewModel.categorizedGroceryItems[category] = [newFoodItem]
                    }
                    
                    viewModel.groceryFoodItems.append(newFoodItem)
                    
                    // Clear the input fields
                    newItemName = ""
                    newItemQuantity = ""
                    newItemUnit = ""
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
            .foregroundStyle(.white)
            .padding(.top, 5)
            
        }
    }
}

#Preview {
    MealPlanningView()
}
