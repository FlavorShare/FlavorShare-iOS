//
//  RemoteImageView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-19.
//

import SwiftUI

struct RemoteImageView: View {
    let fileName: String
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = true
    @State private var error: String? = nil
    
    var body: some View {
        if isLoading {
            ProgressView()
                .onAppear(perform: loadImage)
        } else if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipped()
                .onTapGesture {
                    loadImage() // Retry on tap
                }
        }
    }
    
    /**
     Downloads the image from the server
     */
    private func loadImage() {
        ImageStorageService.shared.downloadImage(fileName: fileName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let downloadedImage):
                    self.image = downloadedImage
                    self.isLoading = false
                case .failure(let downloadError):
                    self.error = downloadError.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
