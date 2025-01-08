//
//  UserEditViewModel.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-06.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI

class UserEditViewModel: ObservableObject {
    // MARK: PROPERTIES
    // ********** USER PROPERTIES **********
    @Published var id: String = ""
    @Published var email: String = ""
    @Published var username: String = ""

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    @Published var phoneNumber: String = ""
    @Published var dateOfBirth: Date = Date()

    var recipes: [String] = []
    var followers: [String] = []
    var following: [String] = []
    
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    @Published var imageURL: String = ""
    @Published var bio: String = ""

    // ********* PASSWORD RESET *************
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
    // ********* OTHER PROPERIES *************
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    @Published var selectedImage: UIImage?
    @Published var isImagePickerPresented: Bool = false
    
    // MARK: loadUserData()
    /**
     Update the user properties with an existing user values
     */
    func loadUserData(user: User) {
        self.id = user.id
        self.email = user.email
        self.username = user.username

        self.firstName = user.firstName
        self.lastName = user.lastName
        
        self.phoneNumber = user.phone
        self.dateOfBirth = user.dateOfBirth
        
        self.recipes = user.recipes
        self.followers = user.followers
        self.following = user.following
        
        self.createdAt = user.createdAt ?? Date()
        self.updatedAt = user.updatedAt ?? Date()
        
        self.imageURL = user.profileImageURL ?? ""
        self.bio = user.bio ?? ""
                
        self.password = ""
        self.newPassword = ""
        self.confirmPassword = ""
    }
    
    func refreshUser() {
        self.isLoading = false
        
        UserAPIService.shared.fetchUserById(withUid: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.loadUserData(user: user)
                    self.isSuccess = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        
        self.isSuccess = false
        self.errorMessage = nil
    }
    
    // MARK: updateUser()
    /**
     This function updates the user properties for the UserEditViewModel
     */
    func updateUser(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        // Validate all fields are filled
        if username.isEmpty || firstName.isEmpty || lastName.isEmpty || dateOfBirth == Date() {
            self.errorMessage = "Please fill in all fields."
            self.isLoading = false
            completion(false)
            
            return
        }
        
        self.updatedAt = Date()
        
        // Upload image
        if let image = selectedImage {
            // Conversion to HEIF
            guard let heifData = ImageConverter.shared.convertUIImageToHEIF(image: image) else {
                self.errorMessage = "Failed to convert image to HEIF."
                self.isLoading = false
                completion(false)
                
                return
            }
                                
            if imageURL.isEmpty {
                imageURL = UUID().uuidString + ".heif"
            }
            
            ImageStorageService.shared.uploadImage(data: heifData, fileName: imageURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):

                        // Update user
                        let updatedUser = User(
                            id: self.id,
                            email: self.email,
                            username: self.username,
                            
                            firstName: self.firstName,
                            lastName: self.lastName,
                            
                            phone: self.phoneNumber,
                            dateOfBirth: self.dateOfBirth,
                            
                            recipes: self.recipes,
                            followers: self.followers,
                            following: self.following,
                            
                            createdAt: self.createdAt,
                            updatedAt: self.updatedAt,
                            
                            profileImageURL: self.imageURL,
                            bio: self.bio
                        )
                        
                        UserAPIService.shared.updateUser(id: self.id, user: updatedUser) { result in
                            DispatchQueue.main.async {
                                self.isLoading = false
                                switch result {
                                case .success(let user):
                                    self.loadUserData(user: user)
                                    self.isSuccess = true
                                    completion(true)
                                                                    
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    completion(false)
                                                                    
                                }
                            }
                        }
                                            
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        completion(false)
                    }
                }
            }
        } else {
            // Update user
            let updatedUser = User(
                id: self.id,
                email: self.email,
                username: self.username,
                
                firstName: self.firstName,
                lastName: self.lastName,
                
                phone: self.phoneNumber,
                dateOfBirth: self.dateOfBirth,
                
                recipes: self.recipes,
                followers: self.followers,
                following: self.following,
                
                createdAt: self.createdAt,
                updatedAt: self.updatedAt,
                
                profileImageURL: self.imageURL,
                bio: self.bio
            )
            
            UserAPIService.shared.updateUser(id: self.id, user: updatedUser) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(let user):
                        self.loadUserData(user: user)
                        self.isSuccess = true
                        completion(true)
                                                
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        completion(false)
                                                
                    }
                }
            }
        }
    }
    
    // MARK: deleteAccount()
    /**
     This function deletes the user account
     */
    func deleteAccount(completion: @escaping (Bool) -> Void)  {
        isLoading = true
        // Delete user
        
        if imageURL.isEmpty {
            UserAPIService.shared.deleteUser(id: self.id) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success:
                        self.isSuccess = true
                        completion(true)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        completion(false)
                    }
                }
            }
        } else {
            ImageStorageService.shared.deleteImage(fileName: imageURL) { result in
                switch result {
                case .success:
                    UserAPIService.shared.deleteUser(id: self.id) { result in
                        DispatchQueue.main.async {
                            self.isLoading = false
                            switch result {
                            case .success:
                                self.isSuccess = true
                                completion(true)
                            case .failure(let error):
                                self.errorMessage = error.localizedDescription
                                completion(false)
                            }
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        completion(false)
                    }
                }
            }
        }
    }
    
    // MARK: changePassword()
    /**
     This function changes the user password
     */
    func changePassword(completion: @escaping (Bool) -> Void)  {
        isLoading = true
        // Change password
        
        isLoading = false
        isSuccess = true
    }
}
