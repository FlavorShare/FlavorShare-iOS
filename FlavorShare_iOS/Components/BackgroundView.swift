//
//  BackgroundView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-18.
//

import SwiftUI

struct BackgroundView: View {
    let imageURL: String
    
    var body: some View {
        ZStack {
            RemoteImageView(fileName: imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
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


#Preview {
    BackgroundView(imageURL: "Background")
}
