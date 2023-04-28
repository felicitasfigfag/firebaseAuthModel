//
//  ContentView.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State private var showRegisterView = false
    
    var body: some View {
        if !showRegisterView {
            LoginEmailView(authenticationViewModel: authenticationViewModel, showRegisterView: $showRegisterView)
        } else {
            RegisterView(authenticationViewModel: authenticationViewModel, showRegisterView: $showRegisterView)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(authenticationViewModel: AuthenticationViewModel())
    }
}
