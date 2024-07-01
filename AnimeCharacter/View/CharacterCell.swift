//
//  CharacterCell.swift
//  AnimeCharacter
//
//  Created by Aswanth K on 01/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCell: View {
    let character: Character

    var body: some View {
        VStack {
            WebImage(url: URL(string: character.image), content: { imge in
                imge.resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 180)
                    .clipped()
            }, placeholder: {
                Rectangle().foregroundColor(.gray)
                    .overlay {
                        ProgressView()
                    }
            })
            VStack(alignment: .leading) {
                Text(character.name.uppercased())
                    .font(.headline)
            }
        }
    }
}
