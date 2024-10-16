//
//  AuthView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    @State private var isLoginMode = true
    
    // Screen Height and Width
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background Image
                Image("Background")
                    .resizable()
                    .blur(radius: 20)
                    .frame(width: screenWidth, height: screenHeight)
                
                BlurView(style: .regular)
                    .frame(width: screenWidth, height: screenHeight)
                
                Rectangle()
                    .fill(Color.black.opacity(0.4))
                    .frame(width: screenWidth, height: screenHeight)
                
                ScrollView {
                    VStack {
                        // App Logo
                        Image("AppLogo")
                            .resizable()
                            .frame(width: screenWidth / 3, height: screenWidth / 3)
                            .padding(.top, 50)
                        
                        // TabView for Ingredients/Instructions
                        HStack (spacing: 0){
                            Button(action: {
                                isLoginMode = true
                            }) {
                                Text("Login")
                                    .foregroundColor(isLoginMode ? .black : .white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .background(isLoginMode ? Color.white : Color.clear)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                isLoginMode = false
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(!isLoginMode ? .black : .white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .background(!isLoginMode ? Color.white : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                        .clipped()
                        .padding()
                        
                        Group {
                            TextField("Email", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.secondarySystemBackground).opacity(0.5))
                                .cornerRadius(10)
                            
                            SecureField("Password", text: $viewModel.password)
                                .padding()
                                .background(Color(.secondarySystemBackground).opacity(0.5))
                                .cornerRadius(10)
                            
                            if !isLoginMode {
                                TextField("Username", text: $viewModel.username)
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.5))
                                    .cornerRadius(10)
                                
                                TextField("First Name", text: $viewModel.firstName)
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.5))
                                    .cornerRadius(10)
                                
                                TextField("Last Name", text: $viewModel.lastName)
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.5))
                                    .cornerRadius(10)
                                
                                TextField("Phone", text: $viewModel.phone)
                                    .keyboardType(.phonePad)
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.5))
                                    .cornerRadius(10)
                                
                                DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                                    .padding()
                                    .background(Color(.secondarySystemBackground).opacity(0.5))
                                    .cornerRadius(10)
                            }
                        }
                        
                        Button(action: {
                            if isLoginMode {
                                Task {
                                    await viewModel.signIn()
                                }
                            } else {
                                Task {
                                    await viewModel.signUp()
                                }
                            }
                        }) {
                            Text(isLoginMode ? "Login" : "Sign Up")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(10)
                        }
                        .padding()
                        
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    .padding()
                } // ScrollView
            } // ZStack
            .ignoresSafeArea(.container, edges: .top)

        } // NavigationStack
    } // body
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
}

