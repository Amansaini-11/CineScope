//
//  FavoritesView.swift
//  CineScope
//
//  Created by Aman Saini on 01/07/2026.
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Query private var favoriteMovies: [FavoriteMovie]
    @Environment(\.modelContext) private var modelContext
    private let firestoreService = FirestoreService()
    
    var body: some View {
        NavigationStack {
            Group {
                if favoriteMovies.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No favorites yet")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Search for movies and tap the heart to save them here")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    List {
                        ForEach(favoriteMovies) { movie in
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(movie.title)
                                        .font(.headline)
                                    Text(movie.year)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Button {
                                    removeFavorite(movie: movie)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
    private func removeFavorite(movie: FavoriteMovie) {
        modelContext.delete(movie)
        firestoreService.removeFavorites(movie: movie)
    }
}

#Preview {
    FavoritesView()
}
