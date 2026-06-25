//
//  Movie.swift
//  CineScope
//
//  Created by Aman Saini on 25/06/2026.
//

//Data Model
import Foundation

struct Movie: Codable, Identifiable {
    
    var title : String
    var year: String
    var imdbID : String
    var poster: String
    var isFavorite : Bool = false
    
    var id : String { imdbID }
    
    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID
    }
}

struct MovieResponse: Codable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
