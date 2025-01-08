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
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var showPhotoPicker = false // Control photo picker presentation
    
    init(user: Binding<User>) {
        self._user = user
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            if let imageURL = user.profileImageURL {
                BackgroundView(imageURL: imageURL)
            }
            
            ScrollView {
                Text("Edit Profile")
                    .font(.title)
                    .padding(.top, 70)
                    .padding(.horizontal)
                    .shadow(radius: 3)
                
                VStack (alignment: .leading) {
                    Text("Profile Details")
                        .font(.headline)
                        .shadow(radius: 3)
                    
                    VStack {
                        VStack {
                            TextField("", text: $viewModel.username, prompt: Text("Username").foregroundStyle(.white.opacity(0.5))
                            )
                            
                            Divider()
                                .overlay(.black)
                                .padding(.vertical, 5)
                            
                            TextField("", text: $viewModel.bio, prompt: Text("Bio").foregroundStyle(.white.opacity(0.5)), axis: .vertical
                            )
                            
                            Divider()
                                .overlay(.black)
                                .padding(.vertical, 5)
                            
                            TextField("", text: $viewModel.firstName, prompt: Text("First Name").foregroundStyle(.white.opacity(0.5))
                            )
                            
                            Divider()
                                .overlay(.black)
                                .padding(.vertical, 5)
                            
                            TextField("", text: $viewModel.lastName, prompt: Text("Last Name").foregroundStyle(.white.opacity(0.5))
                            )
                            
                            Divider()
                                .overlay(.black)
                                .padding(.vertical, 5)
                            
                            DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                            
                            
                            if (viewModel.imageURL != "") {
                                VStack (alignment: .center) {
                                    Divider()
                                        .overlay(.black)
                                        .padding(.vertical, 5)
                                    
                                    Text("Current Image")
                                    RemoteImageView(fileName: viewModel.imageURL, width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                                }
                            }
                            
                            if let selectedImage = viewModel.selectedImage {
                                VStack (alignment: .center) {
                                    Divider()
                                        .overlay(.black)
                                        .padding(.vertical, 5)
                                    
                                    Text("New Image")
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                                        .clipped()
                                }
                            }
                            
                            Divider()
                                .overlay(.black)
                                .padding(.top)
                            
                            Button(action: {
                                viewModel.isImagePickerPresented = true
                            }) {
                                Text("Select Profile Image")
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .background(.black.opacity(0.5))
                    .cornerRadius(10)
                    .clipped()
                    .tint(.white)
                    
                    
                    Text("Contact Information")
                        .font(.headline)
                        .shadow(radius: 3)
                        .padding(.top, 20)
                    
                    VStack {
                        VStack {
                            TextField("", text: $viewModel.email, prompt: Text("Email").foregroundStyle(.white.opacity(0.5))
                            )
                            
                            Divider()
                                .overlay(.black)
                                .padding(.vertical, 5)
                            
                            TextField("", text: $viewModel.phoneNumber, prompt: Text("Phone Number").foregroundStyle(.white.opacity(0.5))
                            )
                        }
                        .padding()
                        .disabled(true)
                    }
                    .background(.black.opacity(0.5))
                    .cornerRadius(10)
                    .clipped()
                    .tint(.white)
                    
                    //                    Section(header: Text("Change Password")) {
                    //                        SecureField("Current Password", text: $viewModel.password)
                    //                        SecureField("New Password", text: $viewModel.newPassword)
                    //                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    //
                    //                        Button(action: {
                    //                            viewModel.changePassword { success in
                    //                                if viewModel.isSuccess {
                    //                                    alertMessage = "Password changed successfully."
                    //                                    showAlert = true
                    //                                } else {
                    //                                    alertMessage = viewModel.errorMessage ?? "Failed to change password. Please try again."
                    //                                    showAlert = true
                    //                                }
                    //                            }
                    //                        }) {
                    //                            Text("Change Password")
                    //                        }
                    //                    }
                    
                    VStack (spacing: 0) {
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
                        .padding()
                        
                        Divider()
                            .overlay(.black)
                            .padding(0)
                        
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
                        .padding()
                        
                    } // end of Section
                    .background(.black.opacity(0.5))
                    .cornerRadius(10)
                    .clipped()
                    .tint(.white)
                    .padding(.top)
                    
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
                .padding(.top)
                .padding(.bottom, 150)
                .padding(.horizontal)
                
            } // end of ScrollView
            .foregroundStyle(.white)
            
            
            HStack (alignment: .top) {
                // Back button to go back in navigation stack
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .clipped()
                        .shadow(radius: 3)
                }
                
                Spacer()
            }
            .padding(.top, 70)
            .padding(.horizontal)
            
        } // end of ZStack
        .ignoresSafeArea(.all)
        .background(.gray)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture().onEnded { value in
                if value.location.x - value.startLocation.x > 150 {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        )
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
    } // end of body
}

#Preview {
    UserEditView(user: .constant(MockData.shared.user))
}
