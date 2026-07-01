//
//  ContentView.swift
//  CineScope
//
//  Created by Aman Saini on 24/06/2026.
//

import SwiftUI
import SwiftData

//Movie list View
struct MovieListView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @StateObject private var viewModel = MovieListViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteMovies : [FavoriteMovie]
    private var firestoreService = FirestoreService()
    
    var body: some View {
        NavigationStack{
            VStack{
                
//                Text("CineScope")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .padding()
                  
                TextField("Search for Movies", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                List($viewModel.movies){ $movie in
                    NavigationLink{
                        MovieDetailViewControllerWrapper(movie: movie)
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
                                
                                if movie.isFavorite{
                                    
                                    let favorite = FavoriteMovie(title: movie.title,
                                                                 year: movie.year,
                                                                 poster: movie.poster,  imdbID: movie.imdbID)
                                    //Adds favorites locally using SwiftData
                                    modelContext.insert(favorite)
                                    
                                    //Adds favorites to firestore cloud
                                    firestoreService.addFavorites(movie: favorite)
                                    
                                    
                                    
                                } else {
                                    
                                    if let existingFavorite = favoriteMovies.first(where: { $0.imdbID == movie.imdbID }) {
                                        
                                        //removes favorites from local storage using SwiftData
                                        modelContext.delete(existingFavorite)
                                        
                                        //removes favotites from firestore cloud
                                        firestoreService.removeFavorites(movie: existingFavorite)
                                    }
                                }
                            }label: {
                                Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                            }.buttonStyle(.plain)
                            .buttonSizing(.automatic)
                        }
                    }
                }
                .onChange(of: viewModel.movies) { oldValue, newValue in
                    for index in viewModel.movies.indices {
                        let isFav = favoriteMovies.contains { $0.imdbID == viewModel.movies[index].imdbID }
                        viewModel.movies[index].isFavorite = isFav
                    }
                }
                .navigationTitle("CineScope")
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: favoriteMovies) { oldValue, newValue in
                    for index in viewModel.movies.indices {
                        let isFav = favoriteMovies.contains { $0.imdbID == viewModel.movies[index].imdbID }
                        viewModel.movies[index].isFavorite = isFav
                    }
                }
               
            }
            .task {
                await viewModel.syncFavoritesFromFirestore(modelContext: modelContext)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        authViewModel.logout()
                    }label:{
                        Text("Logout")
                            .foregroundStyle(Color.red)
                            .font(.footnote)
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
