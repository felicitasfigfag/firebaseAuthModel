//
//  LoginView.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import SwiftUI
import AuthenticationServices

struct LoginEmailView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var showRegisterView: Bool

    var body: some View {
        VStack {
            Text("Sign in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
  
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

            Button(action: performLogin) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .sheet(isPresented: $showRegisterView) {
                RegisterView(authenticationViewModel: authenticationViewModel, showRegisterView: $showRegisterView)
                      }
            
            Text("Or sign in with ")
                .font(.headline)
                .padding(.top, 16)
            // Social login buttons
            HStack {
                Button(action: loginWithFacebook) {
                    HStack {
                        Image("facebookIcon")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Facebook")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.trailing, 8)

                Button(action: loginWithGoogle) {
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

            SignInWithAppleButton(.signIn, onRequest: { request in
                request.requestedScopes = [.email, .fullName]
            }, onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Sign in with Apple succeeded: \(authResults)")
                case .failure(let error):
                    print("Sign in with Apple failed: \(error)")
                }
            })
            .frame(height: 44)
            .padding(.top, 16)
            Button(action: {
                showRegisterView.toggle()
            }) {
                Text("First time? Sign up")
                    .font(.headline)
                    .foregroundColor(Color.blue)
            }
            .padding(.top, 16)
            
            if let messageError = authenticationViewModel.messageError {
                Text("Error \(messageError)")
                    .foregroundColor(.red)
                    .font(.body)
                    .bold()
                    .padding(.top, 20)
            }

        }
        .padding(.top, 64)
    }

    func performLogin() {
        // Replace with your own authentication logic
        authenticationViewModel.login(email: email, password: password)
    }

    func loginWithFacebook() {
        // Replace with your own Facebook login logic
        print("Login with Facebook")
    }

    func loginWithGoogle() {
        // Replace with your own Google login logic
        print("Login with Google")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView(authenticationViewModel: AuthenticationViewModel(), showRegisterView: .constant(false))
    }
}
