//
//  SplashScreen.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isAppActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isAppActive {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                CharacterListView()
            } else {
                LoginView()
            }
        } else {
            VStack {
                VStack {
                    Image("splashImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Text("Anime")
                        .font(Font.custom("Baskerville-Bold", size: 20))
                        .foregroundStyle(.black.opacity(0.5))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear(perform: {
                    withAnimation(.easeInOut(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isAppActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
