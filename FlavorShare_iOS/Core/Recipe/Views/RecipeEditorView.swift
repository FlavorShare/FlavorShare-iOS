import SwiftUI

struct RecipeEditorView: View {
    @State private var id: String
    @State private var title: String
    @State private var imageURL: String
    @State private var ownerId: String
    @State private var createdAt: Date
    @State private var updatedAt: Date
    @State private var description: String
    @State private var ingredients: [String]
    @State private var instructions: [String]
    @State private var cookTime: Int
    @State private var servings: Int
    @State private var likes: Int
    @State private var cuisineType: String
    @State private var nutritionalValues: NutritionalValues?
    @State private var user: User?
    
    @State private var newIngredient: String = ""
    @State private var newInstruction: String = ""
    
    @State private var isNewRecipe = true
    
    init(recipe: Recipe? = nil) {
        if let recipe = recipe {
            _id = State(initialValue: recipe.id)
            _title = State(initialValue: recipe.title)
            _imageURL = State(initialValue: recipe.imageURL)
            _ownerId = State(initialValue: recipe.ownerId)
            _createdAt = State(initialValue: recipe.createdAt)
            _updatedAt = State(initialValue: recipe.updatedAt)
            _description = State(initialValue: recipe.description)
            _ingredients = State(initialValue: recipe.ingredients)
            _instructions = State(initialValue: recipe.instructions)
            _cookTime = State(initialValue: recipe.cookTime)
            _servings = State(initialValue: recipe.servings)
            _likes = State(initialValue: recipe.likes)
            _cuisineType = State(initialValue: recipe.cuisineType)
            _nutritionalValues = State(initialValue: recipe.nutrionalValues)
            _user = State(initialValue: recipe.user)
            
            _isNewRecipe = State(initialValue: false)
        } else {
            _id = State(initialValue: UUID().uuidString)
            _title = State(initialValue: "")
            _imageURL = State(initialValue: "")
            _ownerId = State(initialValue: "")
            _createdAt = State(initialValue: Date())
            _updatedAt = State(initialValue: Date())
            _description = State(initialValue: "")
            _ingredients = State(initialValue: [])
            _instructions = State(initialValue: [])
            _cookTime = State(initialValue: 0)
            _servings = State(initialValue: 0)
            _likes = State(initialValue: 0)
            _cuisineType = State(initialValue: "")
            _nutritionalValues = State(initialValue: nil)
            _user = State(initialValue: nil)
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Recipe Details")) {
                TextField("Title", text: $title)
                TextField("Image URL", text: $imageURL)
                TextField("Owner ID", text: $ownerId)
                DatePicker("Created At", selection: $createdAt, displayedComponents: .date)
                DatePicker("Updated At", selection: $updatedAt, displayedComponents: .date)
                TextField("Description", text: $description)
                TextField("Cuisine Type", text: $cuisineType)
                Stepper(value: $cookTime, in: 0...240) {
                    Text("Cook Time: \(cookTime) minutes")
                }
                Stepper(value: $servings, in: 1...20) {
                    Text("Servings: \(servings)")
                }
                Stepper(value: $likes, in: 0...10000) {
                    Text("Likes: \(likes)")
                }
            }
            
            Section(header: Text("Ingredients")) {
                ForEach(ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
                HStack {
                    TextField("New Ingredient", text: $newIngredient)
                    Button(action: {
                        if !newIngredient.isEmpty {
                            ingredients.append(newIngredient)
                            newIngredient = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            
            Section(header: Text("Instructions")) {
                ForEach(instructions.indices, id: \.self) { index in
                    Text("\(index + 1). \(instructions[index])")
                }
                HStack {
                    TextField("New Instruction", text: $newInstruction)
                    Button(action: {
                        if !newInstruction.isEmpty {
                            instructions.append(newInstruction)
                            newInstruction = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            
            Section(header: Text("Nutritional Values")) {
                if let nutritionalValues = nutritionalValues {
                    TextField("Calories", value: Binding(get: {
                        nutritionalValues.calories
                    }, set: { newValue in
                        self.nutritionalValues?.calories = newValue
                    }), formatter: NumberFormatter())
                    TextField("Protein", value: Binding(get: {
                        nutritionalValues.protein
                    }, set: { newValue in
                        self.nutritionalValues?.protein = newValue
                    }), formatter: NumberFormatter())
                    TextField("Fat", value: Binding(get: {
                        nutritionalValues.fat
                    }, set: { newValue in
                        self.nutritionalValues?.fat = newValue
                    }), formatter: NumberFormatter())
                    TextField("Carbohydrates", value: Binding(get: {
                        nutritionalValues.carbohydrates
                    }, set: { newValue in
                        self.nutritionalValues?.carbohydrates = newValue
                    }), formatter: NumberFormatter())
                } else {
                    Button(action: {
                        self.nutritionalValues = NutritionalValues(calories: 0, protein: 0, fat: 0, carbohydrates: 0)
                    }) {
                        Text("Add Nutritional Values")
                    }
                }
            }
            
            Section {
                Button(action: {
                    // Handle form submission
                    let newRecipe = Recipe(
                        id: id,
                        title: title,
                        imageURL: imageURL,
                        ownerId: ownerId,
                        createdAt: createdAt,
                        updatedAt: updatedAt,
                        description: description,
                        ingredients: ingredients,
                        instructions: instructions,
                        cookTime: cookTime,
                        servings: servings,
                        likes: likes,
                        cuisineType: cuisineType,
                        nutrionalValues: nutritionalValues,
                        user: user
                    )
                    // Save or update the recipe
                    print("Recipe saved: \(newRecipe)")
                }) {
                    Text("Save Recipe")
                }
            }
        }
        .navigationTitle("Recipe Editor")
    }
}

struct RecipeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipeEditorView()
        }
    }
}
