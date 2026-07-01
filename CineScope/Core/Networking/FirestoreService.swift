//
//  FireStoreService.swift
//  CineScope
//
//  Created by Aman Saini on 01/07/2026.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreService{
    
    private let db = Firestore.firestore()
    
    private var userID: String?{
        Auth.auth().currentUser?.uid
    }
    
    
    func addFavorites(movie: FavoriteMovie) {
        
        guard let userID = userID else {
                print("Firestore error : No user")
            return
        }
        
        
        let data: [String: Any] = [
            "title" : movie.title,
            "year" : movie.year,
            "imdbID" : movie.imdbID,
            "poster" : movie.poster
        ]
        
        db.collection("users")
            .document(userID)
            .collection("favorites")
            .document(movie.imdbID)
            .setData(data){ error in
                if let error = error {
                    print("Firestore Error : \(error.localizedDescription)")
                }else{
                    print("Firestore Error : Document added")
                }
                
            }
        
    }
    
    func removeFavorites(movie: FavoriteMovie) {
        
        guard let userID = userID else { return }
        
        db.collection("users")
            .document(userID)
            .collection("favorites")
            .document(movie.imdbID)
            .delete(){error in
                if let error = error {
                    print("Firestore Error \(error.localizedDescription)")
                }
            }
        
    }
    
    func fetchFavorites() async throws -> [FavoriteMovie] {
        
        guard let userID = userID else { return []}
        
        let snapshot = try await db.collection("users")
            .document(userID)
            .collection("favorites")
            .getDocuments()
        
        return snapshot.documents.compactMap{ doc in
            let data = doc.data()
            guard let title = data["title"] as? String,
                  let year = data["year"] as? String,
                  let imdbID = data["imdbID"] as? String,
                  let poster = data["poster"] as? String else {
                      return nil }
            
            return FavoriteMovie(title: title, year: year, poster: poster, imdbID: imdbID)
            
        }
        
        
    }
}

