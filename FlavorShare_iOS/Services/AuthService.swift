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
    
    // MARK: - Methods
    @MainActor
    func signUp(email: String, password: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            self.isAuthenticated = true
            await uploadUserData(uid: result.user.uid, email: email, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.isAuthenticated = true
            await loadUserData()
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.isAuthenticated = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    private func loadUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.userSession = Auth.auth().currentUser
        do {
            self.currentUser = try await UserService.shared.getUser(withUid: uid)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func uploadUserData(uid: String, email: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date) async {
        do {
            let user = User(id: uid, email: email, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
            
            let url = URL(string: "\(baseURL)/register")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(user)
            
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(response)
                throw URLError(.badServerResponse)
            }
            self.currentUser = user
        } catch {
            print(error)
            self.errorMessage = error.localizedDescription
        }
    }
}
