//
//  AuthView.swift
//  CineScope
//
//  Created by Aman Saini on 01/07/2026.
//
import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var isSignedUp : Bool = true
    
    var body: some View {
        
        VStack(spacing : 20){
            Text("CineScope")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                
            Spacer()
            
            Text(isSignedUp ? "Create Account 🫣" :"Welcome back 🥳")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
            
           
                
            TextField("Enter your email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            SecureField("Enter your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                
            
            if !viewModel.errorMessage.isEmpty{
                Text(viewModel.errorMessage)
                    .foregroundStyle(Color.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
                
            
            Button{
                
                if isSignedUp {
                    viewModel.signUp(email: email, password: password)
                }else{
                    viewModel.login(email: email, password: password)
                }
                
            }label: {
                Text(isSignedUp ? "Sign Up" : "Login")
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding()
            }
            
            Button{
                isSignedUp.toggle()
                viewModel.errorMessage = ""
            }label: {
                Text(isSignedUp ? "Already have an Account? Login" : "Don't have an account? Sign Up")
                    .font(.callout)
                    .foregroundStyle(Color.blue)
            }
            
            Spacer()
            
        }.padding()
    }
}


#Preview {
    AuthView()
}
