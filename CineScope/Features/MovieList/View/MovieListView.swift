//
//  ContentView.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI


//Movie list View
struct MovieListView: View {
    
    //List of Movies
    @State private var movies: [Movie] = []
    private var movieService = MovieService()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("CineScope")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                //List does not need for each loop.We can loop through entire list using this method.
                List($movies){ $movie in
                    NavigationLink{
                        MovieDetailView(movie: movie)
                    }label: {
                        HStack{
                            VStack(alignment: .leading, spacing: 10) {
                                Text(movie.title)
                                    .font(.headline)
                                Text(movie.year)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            Button{
                                movie.isFavorite.toggle()
                            }label: {
                                Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                  //task modifier for our list view which will call LoadMovies function
                }.task {
                    await loadMovies()
                }
            }
        }
    }
    
    //LoadMovies function to give a quary and getch data
    func loadMovies() async {
        do {
            movies = try await movieService.searchMovies(query: "batman")
            
        }catch{
            print("Error while Loading movies \(error)")
        }
        
    }
    
}

//Detailed view for each Movie in the list.
struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        
            VStack{
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text(movie.year)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                
            }.padding()
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.large)
        
    }
}




#Preview {
    MovieListView()
}
