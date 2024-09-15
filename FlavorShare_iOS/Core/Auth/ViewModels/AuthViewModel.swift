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
     */
    @MainActor
    func signUp() async {
        self.errorMessage = nil
        
        let error = await AuthService.shared.signUp(email: email, password: password, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
        
        if (error != nil) {
            self.errorMessage = error
            return
        }
        
        await self.signIn()
    }
    
    // MARK: Login
    /**
     This function is used to handle the user login
     */
    @MainActor
    func signIn() async {
        self.errorMessage = nil
        
        let error = await AuthService.shared.signIn(email: email, password: password)
        
        if (error != nil) {
            self.errorMessage = error
            return
        }
    }
}
