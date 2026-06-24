//
//  ContentView.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI

//Data Model
struct Movie: Identifiable {
    let id = UUID()  //gives unique ID to each elements
    var Title : String
    var rating: Double
    var isFavorite :Bool = false
}



//Movie list View
struct MovieListView: View {
    
    //List of Movies
    @State private var MovieList = [
        Movie(Title: "The Shawshank Redemption", rating: 9.3),
        Movie(Title: "United States of War", rating: 9.6),
        Movie(Title: "Planate of Aps", rating: 8.3),
        Movie(Title: "Spider Man", rating: 9.9),
        Movie(Title: "Iron Man", rating: 8.9),
        Movie(Title: "Rockstar", rating: 9.1),
        Movie(Title: "The Shawshank Redemption", rating: 9.3),
        Movie(Title: "United States of War", rating: 9.6),
        Movie(Title: "Planate of Aps", rating: 8.3),
        Movie(Title: "Spider Man", rating: 9.9),
        Movie(Title: "Iron Man", rating: 8.9),
        Movie(Title: "Rockstar", rating: 9.1)
    ]
    
    var body: some View {
        VStack{
            Text("CineScope")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            //List does not need for each loop.We can loop through entire list using this method.
            List($MovieList){ $movie in
                HStack{
                    VStack(alignment: .leading, spacing: 10) {
                        Text(movie.Title)
                            .font(.headline)
                        Text("Rating: \(movie.rating)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    Button{
                        movie.isFavorite.toggle()
                    }label: {
                        Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
        }
    }
}




#Preview {
    MovieListView()
}
