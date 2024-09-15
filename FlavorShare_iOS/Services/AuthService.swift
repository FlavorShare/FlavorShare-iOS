//
//  RecipeAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation
import FirebaseAuth
import Combine

class AuthService: ObservableObject {
    // MARK: - Properties
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    
    static let shared = AuthService()
    
    private let baseURL = "http://localhost:3000"
    
    // MARK: - Initializer
    private init() {
        Task { await loadUserData() }
    }
    
    // MARK: - signUp()
    /**
     This function is used to register a new user to the App using Firebase Authentification.
     - parameter email: user email provided for registration
     - parameter password: user password provided for registration
     - parameter username: username provided for registration
     - parameter firstName: user first name provided for registration
     - parameter lastName: user first name provided for registration
     - parameter phone: user phone number provided for registration
     - parameter dateOfBirth: user date of birth provided for registration
     - returns: String containing error if process failed
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signUp(email: String, password: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date) async -> String? {
        do {
            // 1 - Create new Firebase Auth
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // 2 - Assign the user session and the Authenticated property
            self.userSession = result.user
            self.isAuthenticated = true
            
            // 3 - Create new User Object in the Database
            let feedback = await UserAPIService.shared.uploadUserData(uid: result.user.uid, email: email, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
            if feedback != nil {
                return feedback
            }
            
        } catch {
            return error.localizedDescription
        }
        
        return nil
    }
    
    // MARK: - signIn()
    /**
     This function is used to login an existing user to the App using Firebase Authentification.
     - parameter email: user email provided for registration
     - parameter password: user password provided for registration
     - returns: String containing error if process failed
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signIn(email: String, password: String) async -> String? {
        do {
            // 1 - Authenticate user with Firebase Auth
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            
            // 2 - Assign the user session and the Authenticated property
            self.userSession = result.user
            self.isAuthenticated = true
            
            // 3 - Update current user details
            let feedback = await loadUserData()
            if feedback != nil {
                return feedback
            }
            
        } catch {
            return error.localizedDescription
        }
        
        return nil
    }
    
    // MARK: - signOut()
    /**
     This function is used to logout the current user.
     - returns: String containing error if process failed
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    func signOut() -> String? {
        do {
            // 1 - Logout user
            try Auth.auth().signOut()
            
            // 2 - Update properties
            self.userSession = nil
            self.currentUser = nil
            self.isAuthenticated = false
            
        } catch {
            return error.localizedDescription
        }
        
        return nil
    }
    
    // MARK: - loadUserData()
    /**
     This function is used to load  the current user data.
     - returns: String containing error if process failed
     - Authors: Benjamin Lefebvre
     */
    @MainActor
    private func loadUserData() async -> String? {
        // 1 - Safe guard for user to have current session active
        if let uid = self.userSession?.uid {
            do {
                // 2 - Update currentUser with user model attach to user session
                self.currentUser = try await UserAPIService.shared.getUser(withUid: uid)
                
            } catch {
                return error.localizedDescription
            }
        }
        
        return nil
    }
}
