//
//  AuthViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    @Published var dateOfBirth = Date()
    @Published var errorMessage: String?

    // MARK: Registration
    /**
     This function is used to handle the user registration
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signUp() async {
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
        await self.signIn()
    }

    // MARK: Login
    /**
     This function is used to handle the user login
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signIn() async {
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
