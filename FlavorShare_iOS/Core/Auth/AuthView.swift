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
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Group {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    if !isLoginMode {
                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5)
                        
                        TextField("First Name", text: $viewModel.firstName)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5)
                        
                        TextField("Last Name", text: $viewModel.lastName)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5)
                        
                        TextField("Phone", text: $viewModel.phone)
                            .keyboardType(.phonePad)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5)
                        
                        DatePicker("Date of Birth", selection: $viewModel.dateOfBirth, displayedComponents: .date)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(5)
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
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                .padding()
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(isLoginMode ? "Login" : "Sign Up")
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
