//
//  RegisterView.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import SwiftUI
import AuthenticationServices // for Sign in with Apple

struct RegisterView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Binding var showRegisterView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showRegisterView = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            Text("Sign up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            Button(action: performRegistration) {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            if let error = authenticationViewModel.messageError  {
                Text(error)
                    .bold()
                    .font(.body)
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
            
            // Other registration options
            Text("Or sign up with ")
                .font(.headline)
                .padding(.top, 16)
            
            HStack {
                Button(action: registerWithFacebook) {
                    HStack {
                        Image("facebookIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Facebook")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
                }
                .padding(.trailing, 8)
                
                Button(action: registerWithGoogle) {
                    HStack {
                        Image("googleIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Google")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .padding(.leading, 8)
            }
            .padding(.top, 16)
  
        }
        .padding(.top, 64)
    }
    
    func performRegistration() {
           print("Full Name: \(username), Email: \(email), Password: \(password), Confirm Password: \(confirmPassword)")
           authenticationViewModel.performAuthAction(email: email, password: password, action: .createNewUser)
       }
    
    func registerWithFacebook() {
        // Replace with your own Facebook registration logic
        print("Register with Facebook")
    }
    
    func registerWithGoogle() {
        // Replace with your own Google registration logic
        print("Register with Google")
    }
}
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authenticationViewModel: AuthenticationViewModel(), showRegisterView: .constant(true))
    }
}

