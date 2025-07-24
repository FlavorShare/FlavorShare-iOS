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
                BackgroundView(imageURL: nil)
                    .ignoresSafeArea(.all)

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
                                if (isLoginMode) {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        .cornerRadius(10)
                                        .glassEffect(.clear.interactive())

                                } else {
                                    Text("Login")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        .cornerRadius(10)
                                }
                                
                            }
                            
                            Button(action: {
                                isLoginMode = false
                            }) {
                                if (isLoginMode) {
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        .cornerRadius(10)

                                } else {
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                        .cornerRadius(10)
                                        .glassEffect(.clear.interactive())
                                }
                                
                            }
                        }
                        .background(Color.secondary.opacity(0.5))
                        .cornerRadius(25)
                        .clipped()
                        .padding()
                        
                        Group {
                            TextField("Email", text: $viewModel.email, prompt: Text("Email").foregroundColor(.secondary.opacity(0.5))
                            )
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .glassEffect(.clear.interactive())
                            .cornerRadius(10)
                            
                            SecureField("Password", text: $viewModel.password)
                                .padding()
                                .glassEffect(.clear.interactive())
                                .cornerRadius(10)
                            
                            if !isLoginMode {
                                TextField("Username", text: $viewModel.username)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                    .cornerRadius(10)
                                
                                TextField("First Name", text: $viewModel.firstName)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                    .cornerRadius(10)
                                
                                TextField("Last Name", text: $viewModel.lastName)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                    .cornerRadius(10)
                                
                                TextField("Phone", text: $viewModel.phone)
                                    .keyboardType(.phonePad)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                    .cornerRadius(10)
                                
                                DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        
                        
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
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.white)
                                .frame(height: 40)
                                .padding(.horizontal, 15)
                                .cornerRadius(25)
                                .clipped()
                                .glassEffect(.regular.interactive())
                        }
                        .padding()
                        
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.white)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    } // VStack
                    .padding()
                } // ScrollView
            } // ZStack
            .gesture(
                TapGesture()
                    .onEnded {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        } // NavigationStack
    } // body
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
}

