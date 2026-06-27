//
//  ContentView.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI


//Movie list View
struct MovieListView: View {
    
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Text("CineScope")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    
                
                TextField("Search for Movies", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                List($viewModel.movies){ $movie in
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
                }
            }
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
