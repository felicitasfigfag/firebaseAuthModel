//
//  FacebookAuthentication.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 28/04/2023.
//

import Foundation
import FacebookLogin

class FacebookAuthentication {
        let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil){
            loginManagerLoginResult, error in
            if let error = error {
                print("Error login with Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let token = loginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "Empty token"))
        }
    }
}
