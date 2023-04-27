//
//  HomeView.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome \(authViewModel.user?.email ?? "No user")")
                    .padding(.top, 32)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout"){
                    authViewModel.logout()
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authViewModel: AuthenticationViewModel())
    }
}
