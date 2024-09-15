//
//  RecipeAPIService.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import Foundation
import Combine
import FirebaseAuth

class UserAPIService {
    @Published var currentUser: User?
    
    static let shared = UserAPIService()
    
    private let baseURL = "http://localhost:3000" 

    @MainActor
    func getCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser = try await getUser(withUid: uid)
    }

    func getUser(withUid uid: String) async throws -> User {
        let url = URL(string: "\(baseURL)/users/\(uid)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(User.self, from: data)
    }

    func getAllUsers() async throws -> [User] {
        let url = URL(string: "\(baseURL)/users")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([User].self, from: data)
    }

    func getUsers(forConfig config: UserListConfig) async throws -> [User] {
        switch config {
        case .followers(let uid):
            return try await getFollowers(uid: uid)
        case .following(let uid):
            return try await getFollowing(uid: uid)
        case .likes(let postId):
            return try await getPostLikesUsers(postId: postId)
        case .explore:
            return try await getAllUsers()
        }
    }

    private func getFollowers(uid: String) async throws -> [User] {
        let url = URL(string: "\(baseURL)/users/\(uid)/followers")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([User].self, from: data)
    }

    private func getFollowing(uid: String) async throws -> [User] {
        let url = URL(string: "\(baseURL)/users/\(uid)/following")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([User].self, from: data)
    }

    private func getPostLikesUsers(postId: String) async throws -> [User] {
        // Implement logic to get users who liked a post
        return []
    }

    func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let url = URL(string: "\(baseURL)/users/\(currentUid)/follow/\(uid)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }

    func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let url = URL(string: "\(baseURL)/users/\(currentUid)/unfollow/\(uid)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }

    func isUserFollowed(uid: String) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let url = URL(string: "\(baseURL)/users/\(currentUid)/is-following/\(uid)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let result = try JSONDecoder().decode([String: Bool].self, from: data)
        return result["isFollowing"] ?? false
    }

    func getUserStats(uid: String) async throws -> UserStats {
        let url = URL(string: "\(baseURL)/users/\(uid)/stats")!
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(UserStats.self, from: data)
    }
    
    // MARK: - uploadUserData()
    /**
     This function is used to load the the current user data.
     - returns: String containing error if process failed
     - Authors: Benjamin Lefebvre
     */
    func uploadUserData(uid: String, email: String, username: String, firstName: String, lastName: String, phone: String, dateOfBirth: Date) async -> String? {
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
            return error.localizedDescription
        }
        
        return nil
    }
}
