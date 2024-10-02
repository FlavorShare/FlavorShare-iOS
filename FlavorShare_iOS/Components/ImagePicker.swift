//
//  ImagePicker.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-18.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    /**
        Coordinator class to manage the image picker
     */
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        // MARK: - imagePickerController()
        /**
         Called when the user has selected an image
         - Parameter picker: the image picker
         - Parameter info: the image info
         */
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
    
    // MARK: - makeCoordinator()
    /**
     Creates a coordinator instance to manage the image picker
     - Returns: a Coordinator instance
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // MARK: - makeUIViewController()
    /**
     Creates a UIImagePickerController instance
     - Parameter context: the context
     - Returns: a UIImagePickerController instance
     */
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    // MARK: - updateUIViewControllers()
    /**
     Updates the UIImagePickerController instance
     - Parameter uiViewController: the UIImagePickerController instance
     - Parameter context: the context
     */
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    ImagePicker(image: .constant(nil))
}
