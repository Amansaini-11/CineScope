//
//  FavoriteMovie.swift
//  CineScope
//
//  Created by Aman Saini on 27/06/2026.
//
import SwiftData

@Model
class FavoriteMovie{
    
    var title : String
    var year : String
    var poster : String
    var imdbID : String
    
    init(title: String, year: String, poster: String, imdbID: String) {
        self.title = title
        self.year = year
        self.poster = poster
        self.imdbID = imdbID
    }
}
