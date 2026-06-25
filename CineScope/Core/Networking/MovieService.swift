//
//  MovieService.swift
//  CineScope
//
//  Created by Aman Saini on 25/06/2026.
//

import Foundation

//Created some enums to show Error
enum NetworkError : Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class MovieService {
    
    //Fetching the API_KEY from the Config.plist file
    private var apiKey : String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("Could not find the API_KEY in Config.plist")
        }
        return key
    }
    
    
    //This function will search for Movies in the data base using the API key and URLSession
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


