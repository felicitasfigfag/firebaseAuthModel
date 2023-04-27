//
//  AuthenticationFirebaseDatasource.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import Foundation
import FirebaseAuth
//Datasource se conecta con la SDK de firebase
///Aqui va a estar la logica de la auth, luego se conecta con el repositorio, luego con el VM y dsp con la View.
struct User {
    let email: String
}
final class AuthenticationFirebaseDatasource {
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print("New user created with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
}
