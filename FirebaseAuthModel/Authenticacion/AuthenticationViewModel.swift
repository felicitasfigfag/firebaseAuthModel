//
//  AuthenticationViewModel.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import Foundation

final class AuthenticationViewModel : ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository() ) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        authenticationRepository.createNewUser(email: email, password: password)
        { [ weak self ] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    func logout(){
        do {
            try authenticationRepository.logout()
            self.user = nil
        }
        catch{
            print("Error logout")
        }
    }
}
