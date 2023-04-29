//
//  AuthenticationFirebaseDatasource.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

final class AuthenticationFirebaseDatasource {
    
    private let facebookAuthentication = FacebookAuthentication()
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(email: email)
    }
    
    func performAuthAction(email: String, password: String, action: AuthenticationViewModel.AuthAction, completionBlock: @escaping (Result<User, Error>) -> Void) {
        let authCompletion: (AuthDataResult?, Error?) -> Void = { AuthDataResult, error in
            if let error = error {
                print("Error in auth action \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print("Auth action with \(email) successful")
            completionBlock(.success(.init(email: email)))
        }
        
        switch action {
        case .createNewUser:
            Auth.auth().createUser(withEmail: email, password: password, completion: authCompletion)
        case .login:
            Auth.auth().signIn(withEmail: email, password: password, completion: authCompletion)
        }
    }
    
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error creating a new user \(error.localizedDescription)")
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("New user created with info \(email)")
                    completionBlock(.success(.init(email: email)))
                }
            case .failure(let error):
                print("error signIn with Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }
}
