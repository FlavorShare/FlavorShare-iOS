//
//  Keyboard.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-07.
//

import SwiftUI

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
