//
//  UserEditView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-10-06.
//

import SwiftUI
import PhotosUI

struct UserEditView: View {
    
    @StateObject private var viewModel = UserEditViewModel()
    @Binding var user: User
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showPhotoPicker = false // Control photo picker presentation
    
    init(user: Binding<User>) {
        self._user = user
    }
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                
                if (viewModel.imageURL != "") {
                    VStack {
                        Text("Current Image")
                        RemoteImageView(fileName: viewModel.imageURL, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    }
                }
                
                if let selectedImage = viewModel.selectedImage {
                    VStack {
                        Text("New Image")
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
                    }
                }
                
                Button(action: {
                    viewModel.isImagePickerPresented = true
                }) {
                    Text("Select Image")
                }
                
                TextField("Bio", text: $viewModel.bio)
                TextField("User", text: $viewModel.username)
                TextField("First Name", text: $viewModel.firstName)
                TextField("Last Name", text: $viewModel.lastName)
                
                DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
            }
            
            Section(header: Text("Contact Information")) {
                TextField("Email", text: $viewModel.email)
                TextField("Phone Number", text: $viewModel.phoneNumber)
            }
            
            Section(header: Text("Change Password")) {
                SecureField("Current Password", text: $viewModel.password)
                SecureField("New Password", text: $viewModel.newPassword)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                
                Button(action: {
                    viewModel.changePassword { success in
                        if viewModel.isSuccess {
                            alertMessage = "Password changed successfully."
                            showAlert = true
                        } else {
                            alertMessage = viewModel.errorMessage ?? "Failed to change password. Please try again."
                            showAlert = true
                        }
                    }
                }) {
                    Text("Change Password")
                }
            }
            
            Section {
                Button(action: {
                    viewModel.updateUser { success in
                        if success {
                            user = User(id: user.id,
                                        email: viewModel.email,
                                        username: viewModel.username,
                                        firstName: viewModel.firstName,
                                        lastName: viewModel.lastName,
                                        phone: viewModel.phoneNumber,
                                        dateOfBirth: viewModel.dateOfBirth,
                                        recipes: user.recipes,
                                        followers: user.followers,
                                        following: user.following,
                                        createdAt: user.createdAt,
                                        updatedAt: user.updatedAt,
                                        profileImageURL: user.profileImageURL,
                                        bio: viewModel.bio)
                            dismiss()
                        } else {
                            alertMessage = "Failed to update profile. Please try again."
                            showAlert = true
                        }
                    }
                }) {
                    Text("Update Profile")
                }
                
                Button(action: {
                    viewModel.deleteAccount { success in
                        if success {
                            dismiss()
                        } else {
                            alertMessage = "Failed to delete account. Please try again."
                            showAlert = true
                        }
                    }
                }) {
                    Text("Delete Account")
                        .foregroundColor(.red)
                } // end of Button
            } // end of Section
            
            Divider()
                .background(Color.clear)
                .padding(.vertical, 15)
            
        } // end of Form
        .navigationTitle("Edit Profile")
        .onAppear {
            viewModel.loadUserData(user: user)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(image: $viewModel.selectedImage, isPresented: $viewModel.isImagePickerPresented)
        }
    } // end of body
}

#Preview {
    UserEditView(user: .constant(MockData.shared.user))
}
