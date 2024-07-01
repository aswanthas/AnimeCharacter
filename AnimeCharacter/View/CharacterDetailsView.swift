//
//  CharacterDetailsView.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailsView: View {
    let character: Character

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            WebImage(url: URL(string: character.image), content: { imge in
                imge.resizable()
            }, placeholder: {
                Rectangle().foregroundColor(.gray)
            })
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 300)

            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text("Species: \(character.species)")

                Text("Status: \(character.status)")

                    Text("Location: \( character.location.name)")
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(character.name), displayMode: .inline)
        .padding()
    }
}
