//
//  Movie.swift
//  CineScope
//
//  Created by Aman Saini on 25/06/2026.
//
import Foundation


//Data Model for our Movies
struct Movie: Codable, Identifiable, Equatable{
    
    var title : String
    var year: String
    var imdbID : String
    var poster: String
    var isFavorite : Bool = false
    
    var id : String { imdbID }
    
    //CodingKeys to explicitly convert the variable string to capital letter for JSON data
    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID
    }
}

//MovieResponse for outer layer of the JSON data 
struct MovieResponse: Codable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
