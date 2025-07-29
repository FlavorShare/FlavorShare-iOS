import SwiftUI

struct RecipeDetailsView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    @Binding var viewDetails: Tabs
       
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                HStack(spacing: 0) {
                    ForEach(Tabs.allCases, id: \.self) { tab in
                        Button(action: {
                            viewDetails = tab
                        }) {
                            Text(tab.rawValue)
                                .foregroundColor(.white)
                                .fontWeight(viewDetails == tab ? .bold : .regular)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .contentShape(Rectangle())
                        }
                    }
                }
                .padding(1)
            }
            .cornerRadius(25)
            .glassEffect(.clear.interactive())
            .padding(.bottom)
            
            Group {
                switch (viewDetails) {
                case .ingredients:
                    IngredientTab()
                        .environmentObject(viewModel)
                case .instructions:
                    InstructionTab()
                        .environmentObject(viewModel)
                case .reviews:
                    ReviewTab()
                        .environmentObject(viewModel)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.bottom, 100)
            .foregroundStyle(.white)
            .shadow(radius: 3)
        }
    }
}
