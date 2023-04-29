//
//  AuthenticationRepository.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//
import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser() -> User? {
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func performAuthAction(email: String, password: String, action: AuthenticationViewModel.AuthAction, completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDatasource.performAuthAction(email: email, password: password, action: action, completionBlock: completionBlock)
    }
    
    func loginFacebok(completionBlock: @escaping( Result <User, Error>) -> Void) {
        authenticationFirebaseDatasource.loginWithFacebook(completionBlock: completionBlock)
    }
    
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
}
