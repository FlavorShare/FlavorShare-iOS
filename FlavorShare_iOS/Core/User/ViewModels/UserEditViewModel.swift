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
    @Published var id: String = ""
    @Published var imageURL: String = ""
    @Published var bio: String = ""
    @Published var username: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
    
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
        self.imageURL = user.profileImageURL ?? ""
        
        self.bio = user.bio ?? ""
        self.username = user.username
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.dateOfBirth = user.dateOfBirth
        self.email = user.email
        self.phoneNumber = user.phone
                
        self.password = ""
        self.newPassword = ""
        self.confirmPassword = ""
    }
    
    // MARK: updateUser()
    /**
     This function updates the user properties for the UserEditViewModel
     */
    func updateUser(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
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
