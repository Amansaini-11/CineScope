//
//  AuthViewModel.swift
//  CineScope
//
//  Created by Aman Saini on 01/07/2026.
//
import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var errorMessage : String = ""
    
    init(){
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
    
    func signUp(email : String, password : String){
        Auth.auth().createUser(withEmail: email, password: password){
            Result, error in
            DispatchQueue.main.async{
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")

                }else {
                    self.isLoggedIn = true
                    print("Signed Up successfully")

                }
            }
        }
    }
    
    func login(email : String, password : String){
        Auth.auth().signIn(withEmail: email, password: password){ Result, error in
            DispatchQueue.main.async{
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                }else{
                    self.isLoggedIn = true
                    print("Logged In successfully")
                }
            }
            
        }
    }
    
    func logout(){
        try? Auth.auth().signOut()
        self.isLoggedIn = false
    }
    
}
