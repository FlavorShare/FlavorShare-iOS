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
    
    // MARK: - fetchCurrentUser()
    /**
     Get the logged in user data
     - returns: String containing error if process failed
     */
    @MainActor
    func fetchCurrentUser() async throws -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return "No user authenticated" }
        
        return try await withCheckedThrowingContinuation { continuation in
            fetchUserById(withUid: uid) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        self?.currentUser = user
                        continuation.resume(returning: nil)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    // MARK: - fetchUserById()
    /**
     Get the user for a specified user ID
     - parameter withUid: Represent the ID for the wanted user
     - returns: The user found OR the error encountered
     */
    func fetchUserById(withUid id: String, completion: @escaping (Result<User, Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/user/\(id)", completion: completion)
    }
    
    // MARK: - uploadUserData()
    /**
     This function is used to register the the new user data.
     - parameter user: The new user to add to the database
     - returns: String containing error if process failed
     */
    func uploadUserData(user: User) async -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(user)
            return try await withCheckedThrowingContinuation { continuation in
                AppAPIHandler.shared.performRequest(endpoint: "/user", method: "POST", body: data) { (result: Result<User, Error>) in
                    switch result {
                    case .success(let user):
                        self.currentUser = user
                        continuation.resume(returning: nil)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        } catch {
            return error.localizedDescription
        }
    }
    
    // MARK: - updateUser()
    /**
     Update the existing user with the edited data
     - parameter id: The ID for the edited used
     - parameter recipe: The new user to update to the database
     - returns: The edited user OR the encoutered error
     */
    func updateUser(id: String, user: User, completion: @escaping (Result<User, Error>) -> Void) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
            let data = try encoder.encode(user)
            AppAPIHandler.shared.performRequest(endpoint: "/user/\(id)", method: "PUT", body: data, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - deleteUser()
    /**
     Delete an existing user
     - parameter id: The ID for the user to delete
     - returns: Nothing OR the encoutered error
     
     */
    func deleteUser(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        AppAPIHandler.shared.performRequest(endpoint: "/user/\(id)", method: "DELETE") { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension UserAPIService {
    // MARK: Functions Commented Out
    
    //    func fetchAllUsers() async throws -> [User] {
    //        let url = URL(string: "\(baseURL)/users")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //        return try JSONDecoder().decode([User].self, from: data)
    //    }
    //
    //    func getUsers(forConfig config: UserListConfig) async throws -> [User] {
    //        switch config {
    //        case .followers(let uid):
    //            return try await getFollowers(uid: uid)
    //        case .following(let uid):
    //            return try await getFollowing(uid: uid)
    //        case .likes(let postId):
    //            return try await getPostLikesUsers(postId: postId)
    //        case .explore:
    //            return try await getAllUsers()
    //        }
    //    }
    //
    //    private func getFollowers(uid: String) async throws -> [User] {
    //        let url = URL(string: "\(baseURL)/users/\(uid)/followers")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //        return try JSONDecoder().decode([User].self, from: data)
    //    }
    //
    //    private func getFollowing(uid: String) async throws -> [User] {
    //        let url = URL(string: "\(baseURL)/users/\(uid)/following")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //        return try JSONDecoder().decode([User].self, from: data)
    //    }
    //
    //    private func getPostLikesUsers(postId: String) async throws -> [User] {
    //        // Implement logic to get users who liked a post
    //        return []
    //    }
    //
    //    func follow(uid: String) async throws {
    //        guard let currentUid = Auth.auth().currentUser?.uid else { return }
    //        let url = URL(string: "\(baseURL)/users/\(currentUid)/follow/\(uid)")!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        let (_, response) = try await URLSession.shared.data(for: request)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //    }
    //
    //    func unfollow(uid: String) async throws {
    //        guard let currentUid = Auth.auth().currentUser?.uid else { return }
    //        let url = URL(string: "\(baseURL)/users/\(currentUid)/unfollow/\(uid)")!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //        let (_, response) = try await URLSession.shared.data(for: request)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //    }
    //
    //    func isUserFollowed(uid: String) async throws -> Bool {
    //        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
    //        let url = URL(string: "\(baseURL)/users/\(currentUid)/is-following/\(uid)")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //        let result = try JSONDecoder().decode([String: Bool].self, from: data)
    //        return result["isFollowing"] ?? false
    //    }
    //
    //    func getUserStats(uid: String) async throws -> UserStats {
    //        let url = URL(string: "\(baseURL)/users/\(uid)/stats")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw URLError(.badServerResponse)
    //        }
    //        return try JSONDecoder().decode(UserStats.self, from: data)
    //    }
}
