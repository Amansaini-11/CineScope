//
//  MovieListViewModel.swift
//  CineScope
//
//  Created by Aman Saini on 27/06/2026.
//
import Foundation
import Combine
import UIKit
import SwiftUI
import SwiftData

class MovieListViewModel : ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var movies: [Movie] = []
    @Published var searchText : String = ""
    
    private var firestoreService = FirestoreService()
    private var movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init(){
        $searchText
            .debounce(for: .seconds(0.2) , scheduler: DispatchQueue.main)
            .sink{ [weak self] query in
                
                Task{
                    await self?.search(query: query)
                }
                
            }.store(in: &cancellables)
    }
    
    
    
    func search(query: String) async {
        
        guard !query.isEmpty else {
            movies = []
            return
        }
        do {
            movies = try await movieService.searchMovies(query: query)
        }catch{
            print("Error: \(error)")
        }
    }
    
    func syncFavoritesFromFirestore(modelContext: ModelContext) async {
        do {
            let cloudFavorites = try await firestoreService.fetchFavorites()
            print("Cloud favorites count: \(cloudFavorites.count)")
            for favorite in cloudFavorites {
                print("Fetched from Firestore: \(favorite.title)")
                modelContext.insert(favorite)
            }
        } catch {
            print("Sync error: \(error)")
        }
    }
}
