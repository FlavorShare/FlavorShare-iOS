//
//  AuthView.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2024-09-13.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phone = ""
    @State private var dateOfBirth = Date()
    @State private var isLoginMode = true
    
    var body: some View {
        VStack {
            Picker(selection: $isLoginMode, label: Text("Picker here")) {
                Text("Login").tag(true)
                Text("Sign Up").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Group {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                
                if !isLoginMode {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    TextField("First Name", text: $firstName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    TextField("Last Name", text: $lastName)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                    
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5)
                }
            }
            
            Button(action: {
                if isLoginMode {
                    Task {
                        await viewModel.signIn(email: email, password: password)
                    }
                } else {
                    Task {
                        await viewModel.signUp(email: email, password: password, username: username, firstName: firstName, lastName: lastName, phone: phone, dateOfBirth: dateOfBirth)
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

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
