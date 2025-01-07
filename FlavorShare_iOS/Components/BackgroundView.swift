//
//  BackgroundView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-18.
//

import SwiftUI

struct BackgroundView: View {
    let imageURL: String?
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        if (imageURL == nil) {
            ZStack {
                Image("Background")
                    .resizable()
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
                
                BlurView(style: .regular)
                    .frame(width: screenWidth, height: screenHeight)
                
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: screenWidth, height: screenHeight)
            }
        } else {
            ZStack {
                RemoteImageView(fileName: imageURL!, width: screenWidth, height: screenHeight)
                    .blur(radius: 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(.all)
                BlurView(style: .regular)
                    .ignoresSafeArea(.all)
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .ignoresSafeArea(.all)
            }
        }
    }
}


#Preview {
    BackgroundView(imageURL: "Background")
}
