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
    
    // MARK: - fetchCurrentUser()
    /**
     Get the logged in user data
     - returns: String containing error if process failed
     */
    @MainActor
    func fetchCurrentUser() async throws -> String? {
        var errorMessage: String? = nil
        
        guard let uid = Auth.auth().currentUser?.uid else { return "No user authenticated" }
        
        fetchUserById(withUid: uid) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.currentUser = user
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
        return errorMessage
    }
    
    // MARK: - fetchUserById()
    /**
     Get the user for a specified user ID
     - parameter withUid: Represent the ID for the wanted user
     - returns: The user found OR the error encountered
     */
    func fetchUserById(withUid id: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/users/\(id)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - uploadUserData()
    /**
     This function is used to register the the new user data.
     - returns: String containing error if process failed
     */
    func uploadUserData(user: User) async -> String? {
        do {
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
