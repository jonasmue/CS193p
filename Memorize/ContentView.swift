//
//  ContentView.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var emojiGame: EmojiMemoryGame
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiGame.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.blue)
        .font(emojiGame.cards.count == 10 ? Font.body: Font.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white).aspectRatio(2.0/3.0, contentMode: .fit)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0).aspectRatio(2.0/3.0, contentMode: .fit)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill().aspectRatio(2.0/3.0, contentMode: .fit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiGame: EmojiMemoryGame())
    }
}
