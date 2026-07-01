//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct CineScopeApp: App {
    
    @StateObject var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            if authViewModel.isLoggedIn {
                
                MainTabView()
                    .environmentObject(authViewModel)
                
            }else{
                
                AuthView()
                    .environmentObject(authViewModel)
            }
            
        }.modelContainer(for: FavoriteMovie.self)
    }
}
