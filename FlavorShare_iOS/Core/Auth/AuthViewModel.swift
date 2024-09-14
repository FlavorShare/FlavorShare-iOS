//
//  AuthViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    init() {
        // Check if the user is already authenticated
        self.isAuthenticated = Auth.auth().currentUser != nil
    }

    func signUp(email: String, password: String) async {
        await AuthService.shared.signUp(email: email, password: password, username: "Test", firstName: "John", lastName: "Doe", phone: "8192085173", dateOfBirth: Date())
        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self.errorMessage = error.localizedDescription
//                }
//                return
//            }
            self.signIn(email: email, password: password) // Automatically sign in after registration
//        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isAuthenticated = false
            }
        } catch let signOutError as NSError {
            DispatchQueue.main.async {
                self.errorMessage = signOutError.localizedDescription
            }
        }
    }
}
