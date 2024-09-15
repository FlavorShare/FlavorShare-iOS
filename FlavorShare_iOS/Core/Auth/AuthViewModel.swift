//
//  AuthViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var errorMessage: String?

    // MARK: Registration
    /**
     This function is used to handle the user registration
     - parameter email: user email provided for registration
     - parameter password: user password provided for registration
     - parameter username: username provided for registration
     - parameter firstName: user first name provided for registration
     - parameter lastName: user first name provided for registration
     - parameter phone: user phone number provided for registration
     - parameter dateOfBirth: user date of birth provided for registration
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signUp(email: String, password: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date) async {
        // 1 - Reset Error Message
        self.errorMessage = nil
        
        // 2 - Register
        let error = await AuthService.shared.signUp(email: email, password: password, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
        
        // 3 - Error Handling
        if (error != nil) {
            self.errorMessage = error
            return
        }
        
        // 4 - Login User
        await self.signIn(email: email, password: password)
    }

    // MARK: Login
    /**
     This function is used to handle the user login
     - parameter email: user email provided for registration
     - parameter password: user password provided for registration
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signIn(email: String, password: String) async {
        // 1 - Reset Error Message
        self.errorMessage = nil
        
        // 2 - Login User
        let error = await AuthService.shared.signIn(email: email, password: password)
        
        // 2 - Error Handling
        if (error != nil) {
            self.errorMessage = error
            return
        }
    }
}
