//
//  ImagePicker.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-18.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool  // Add this binding to control the dismissal
    
    // Coordinator to manage the picker
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // When the user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.isPresented = false  // Explicitly dismiss the picker
        }
        
        // If the user cancels
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false  // Explicitly dismiss the picker
        }
    }
    
    // Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Create the picker controller
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    // Update method (not needed here)
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ImagePicker(image: .constant(nil), isPresented: .constant(true))
}
