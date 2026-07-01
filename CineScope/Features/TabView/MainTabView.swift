//
//  MainTabView.swift
//  CineScope
//
//  Created by Aman Saini on 01/07/2026.
//
import SwiftUI
import Foundation
import SwiftData

struct MainTabView: View{
    @State private var isSelected = false
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.modelContext) var modelContext
    
    var body: some View{
        
        TabView{
            
            MovieListView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tint(.blue)
            
        }
        
    }
    
}

#Preview {
    MainTabView()
}
