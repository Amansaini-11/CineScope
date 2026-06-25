//
//  MovieService.swift
//  CineScope
//
//  Created by Aman Saini on 25/06/2026.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class MovieService {
    
    private let apiKey = "af7f5bcd"
    
    func searchMovies(query: String) async throws -> [Movie]{
        
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(query)")else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
         httpResponse.statusCode == 200 else{
            throw NetworkError.requestFailed
        }
            
        let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
        
        return decoded.search
        
        }
    }
    

