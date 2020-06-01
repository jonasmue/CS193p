//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

typealias EmojiGameModel = MemoryGame<String>

class EmojiMemoryGame: ObservableObject {
    @Published private var model: EmojiGameModel!
    private (set) var theme: Theme!
    
    init() {
        initialize()
    }
    
    private func initialize() {
        (self.model, self.theme) = EmojiMemoryGame.createMemoryGame()
    }
    
    static func createMemoryGame() -> (EmojiGameModel, Theme) {
        let theme = EmojiMemoryGameThemeFactory.getRandomTheme()
        let contents = theme.contents.shuffled()
        // Get nicely aligned number of pairs
        let numberOfCardPairs = theme.numCardPairs ??
            Array(2..<theme.contents.count).filter {($0 * 2).isSquare()}.randomElement()!
        let game = EmojiGameModel(numberOfPairsOfCards: numberOfCardPairs) {contents[$0 % contents.count]}
        return (game, theme)
    }
    
    // MARK: - Accessors
    
    var cards: Array<EmojiGameModel.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func choose(card: EmojiGameModel.Card) {
        model.choose(card)
        if model.isFinished {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(newGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func newGame() {
        initialize()
    }
}
