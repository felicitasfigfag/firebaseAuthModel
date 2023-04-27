//
//  FirebaseAuthModelApp.swift
//  FirebaseAuthModel
//
//  Created by Felicitas Figueroa Fagalde on 27/04/2023.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct FirebaseAuthModelApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let user = authenticationViewModel.user {
                HomeView(authViewModel: authenticationViewModel)
            } else {
                AuthenticationView(authenticationViewModel: authenticationViewModel)
            }
            
        }
    }
}
