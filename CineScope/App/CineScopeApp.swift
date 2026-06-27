//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI
import SwiftData

@main
struct CineScopeApp: App {
    var body: some Scene {
        WindowGroup {
            
            MovieListView()
            
        }.modelContainer(for: FavoriteMovie.self)
    }
}
