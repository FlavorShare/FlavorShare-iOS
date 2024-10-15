//
//  SearchBar.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-13.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Search recipes...", text: $searchText)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.white).opacity(0.5))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
//                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
