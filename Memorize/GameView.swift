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
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.emojiGame.choose(card: card)
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
        }.navigationViewStyle(StackNavigationViewStyle())
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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.2)
                
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.8).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat { min(size.width, size.height) * 0.7 }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[2])
        return GameView(emojiGame: game)
    }
}
