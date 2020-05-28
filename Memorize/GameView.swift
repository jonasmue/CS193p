//
//  GameView.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        NavigationView {
            Grid(emojiGame.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiGame.choose(card: card)
                }.padding(5)
            }
            .padding()
            .foregroundColor(emojiGame.theme.color)
            .navigationBarTitle(emojiGame.theme.name)
            .navigationBarItems(trailing:
                Button("New Game") {
                    self.emojiGame.newGame()
                }
            )
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String, Color>.Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            self.body(for: geometry.size)
        })
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiGame: EmojiMemoryGame())
    }
}
