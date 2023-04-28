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
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
