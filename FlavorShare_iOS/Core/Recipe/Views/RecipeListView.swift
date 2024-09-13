import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = [
        Recipe(
            id: "1",
            title: "Spaghetti Carbonara",
            imageURL: "https://www.allrecipes.com/thmb/N3hqMgkSlKbPmcWCkHmxekKO61I=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Easyspaghettiwithtomatosauce_11715_DDMFS_1x2_2425-c67720e4ea884f22a852f0bb84a87a80.jpg",
            ownerId: "1",
            createdAt: Date(),
            updatedAt: Date(),
            description: "A classic Italian pasta dish.",
            ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
            instructions: ["Boil the spaghetti.", "Cook the pancetta.", "Mix eggs and cheese.", "Combine all ingredients."],
            cookTime: 30,
            servings: 4,
            likes: 100,
            cuisineType: "Italian",
            nutrionalValues: NutritionalValues(calories: 500, protein: 20, fat: 25, carbohydrates: 50),
            user: User(
                id: "1",
                email: "user@example.com",
                username: "user123",
                firstName: "John",
                lastName: "Doe",
                phone: "123-456-7890",
                dateOfBirth: Date(),
                profileImageURL: nil,
                bio: "This is a bio",
                isFollowed: false,
                stats: UserStats(followers: 100, following: 50, posts: 10),
                isCurrentUser: false
            )
        )
    ]
    
    @State private var selectedCategory: String = "All"
    private let categories: [String] = ["All", "Italian", "Chinese", "Indian", "Mexican", "American", "French", "Japanese", "Mediterranean", "Thai", "Spanish"]

    var filteredRecipes: [Recipe] {
        if selectedCategory == "All" {
            return recipes
        } else {
            return recipes.filter { $0.cuisineType == selectedCategory }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Horizontal Scroll Bar for Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .padding()
                                .background(selectedCategory == category ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding()
                }

                // Recipe List
                List(filteredRecipes) { recipe in
                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                        HStack {
                            if (recipe.imageURL != "") {
                                let url = URL(string: recipe.imageURL)
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(recipe.title)
                                    .font(.headline)
                                Text(recipe.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Recipes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: RecipeEditorView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
