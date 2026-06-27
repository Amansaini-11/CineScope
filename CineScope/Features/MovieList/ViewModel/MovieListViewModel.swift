//
//  MovieListViewModel.swift
//  CineScope
//
//  Created by Aman Saini on 27/06/2026.
//
import Foundation
import Combine

class MovieListViewModel : ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var searchText : String = ""
    
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
    
}
