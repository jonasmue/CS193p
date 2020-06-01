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
            VStack(alignment: .leading) {
                Text("Score: \(emojiGame.score)")
                Grid(emojiGame.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation {
                            if !card.isFaceUp {
                            self.emojiGame.choose(card: card)
                            }
                        }
                    }.padding(self.cardPadding)
                }
                .foregroundColor(emojiGame.theme.color)
                .navigationBarTitle(emojiGame.theme.name)
                .navigationBarItems(trailing:
                    Button("New Game") {
                        withAnimation(.default) {
                            self.emojiGame.newGame()
                        }
                    }
                )
            }.padding(.horizontal)
        }
    }
    
    
    // MARK: - Drawing Constants
    
    let cardPadding: CGFloat = 6.5
}

struct CardView: View {
    var card: EmojiGameModel.Card
    
    var body: some View {
        GeometryReader(content: {geometry in
            self.body(for: geometry.size)
        })
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                Text(self.card.content).animation(.easeOut)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .shadow(radius: 2.0)
    }
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiGame: EmojiMemoryGame())
    }
}
