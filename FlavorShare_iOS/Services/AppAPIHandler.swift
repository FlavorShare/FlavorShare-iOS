//
//  AppAPIHandler.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-23.
//

import Foundation
import FirebaseAuth

struct EmptyResponse: Decodable {}

class AppAPIHandler {
    
    static let shared = AppAPIHandler()
    
    private let baseURL = EnvironmentVariables.APIBaseURL
    
    /**
        Perform a request to the App API
        - Parameters:
            - endpoint: The endpoint to call on the API
            - method: The HTTP method to use (default is GET)
            - body: The body of the request
            - completion: The completion handler to call when the request is complete
     */
    func performRequest<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        print("Performing request to \(endpoint)")
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        Task {
            do {
                var request = try await AppAPIHandler.shared.requestBuilder(url: url)
                request.httpMethod = method
                if let body = body {
                    request.httpBody = body
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                    print("Error: \(response)")
                    throw URLError(.badServerResponse)
                }
                
                if T.self == EmptyResponse.self {
                    completion(.success(EmptyResponse() as! T))
                } else {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    /**
        Build the request to the App API
        - Parameters:
            - url: The URL to call on the API
     */
    func requestBuilder(url: URL) async throws -> URLRequest {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "No authenticated user", code: 0, userInfo: nil)
        }
        
        let idToken = try await user.getIDToken()
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        request.addValue(EnvironmentVariables.appAPIKey, forHTTPHeaderField: "x-api-key")
        request.addValue(EnvironmentVariables.appAPISecret, forHTTPHeaderField: "x-api-secret")
        
        return request
    }
}
