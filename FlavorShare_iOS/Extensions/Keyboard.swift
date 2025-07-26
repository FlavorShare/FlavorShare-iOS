//
//  Keyboard.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-07.
//

import SwiftUI
import Combine

struct DismissKeyboardView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tapGesture = UITapGestureRecognizer(target: viewController, action: #selector(UIViewController.dismissKeyboard))
        viewController.view.addGestureRecognizer(tapGesture)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

}

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0 // The height of the keyboard
    @Published var isKeyboardVisible: Bool = false // Boolean to indicate visibility

    private var keyboardWillShowCancellable: AnyCancellable?
    private var keyboardWillHideCancellable: AnyCancellable?

    init() {
        // Subscribe to keyboardWillShowNotification
        keyboardWillShowCancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                // Extract the keyboard frame from the notification's user info
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            }
            .sink { [weak self] height in
                self?.currentHeight = height
                self?.isKeyboardVisible = true // Set to true when keyboard shows
            }

        // Subscribe to keyboardWillHideNotification
        keyboardWillHideCancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.currentHeight = 0
                self?.isKeyboardVisible = false // Set to false when keyboard hides
            }
    }
}
