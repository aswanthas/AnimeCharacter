//
//  LoginView.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    UserDefaults.standard.set(password, forKey: "userPassword")
                    self.isLoggedIn = true
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .onAppear {
                // Check if user is already logged in
                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                    self.isLoggedIn = true
                }
            }
            .background(
                NavigationLink(
                    destination: CharacterListView(),
                    isActive: $isLoggedIn,
                    label: {
                        EmptyView()
                    })
            )
        }
    }
}

#Preview {
    LoginView()
}
