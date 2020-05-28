//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

typealias EmojiGameModel = MemoryGame<String, Color>

class EmojiMemoryGame: ObservableObject {
    @Published private var game: EmojiGameModel = createMemoryGame()
    
    static func createMemoryGame() -> EmojiGameModel {
        return EmojiGameModel(theme: getRandomTheme())
    }
    
    // MARK: - Accessors
    
    var cards: Array<EmojiGameModel.Card> {
        game.cards
    }
    
    var theme: EmojiGameModel.Theme {
        game.theme
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intents
    
    func choose(card: EmojiGameModel.Card) {
        game.choose(card)
        if game.isFinished {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(newGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func newGame() {
        game = EmojiMemoryGame.createMemoryGame()
    }
    
    // MARK: - Themes
    
    private static func getRandomTheme() -> EmojiGameModel.Theme {
        let theme = EmojiTheme.allCases.randomElement()!
        switch theme {
        case .halloween:
            let contents = ["👻", "🕷", "🕸", "🎃", "🧛🏻‍♀️", "🦇", "⚰️", "🔮", "🧟‍♂️"]
            return MemoryGame<String, Color>.Theme(name: "Halloween", contents: contents, numCardPairs: contents.count, color: Color.orange)
        case .animals:
            let contents = ["🦓", "🦒", "🐔", "🐰", "🐡", "🐍", "🐋", "🐥", "🐦", "🦊", "🦮", "🐙", "🐮", "🦋", "🐘", "🦞", "🦚", "🦘", "🐼", "🦆", "🦇", "🐧"]
            return MemoryGame<String, Color>.Theme(name: "Animals", contents: contents, numCardPairs: nil, color: Color.green)
        case .food:
            let contents = ["🧀", "🥕", "🍩", "🌽", "🍶", "🍺", "🍏", "🍞", "🍪", "🧇", "🌯", "🍑", "🍱", "🥒", "🥑", "🍔", "🍰", "🍋", "🍉", "🧆", "🥯", "🥗", "🍟"]
            return MemoryGame<String, Color>.Theme(name: "Food", contents: contents, numCardPairs: nil, color: Color.red)
        case .vehicles:
            let contents = ["🚛", "🚚", "🚲", "🚠", "🏎", "🚝", "🛥", "🚁"]
            return MemoryGame<String, Color>.Theme(name: "Vehicles", contents: contents, numCardPairs: contents.count, color: Color.gray)
        case .faces:
            let contents = ["😙", "😮", "🤕", "😋", "😷", "😊", "🤖", "🤓"]
            return MemoryGame<String, Color>.Theme(name: "Faces", contents: contents, numCardPairs: nil, color: Color.yellow)
        case .sports:
            let contents = ["🏈", "⚾️", "⚽️", "🥍", "⛸", "🏀"]
            return MemoryGame<String, Color>.Theme(name: "Sports", contents: contents, numCardPairs: contents.count, color: Color.blue)
        }
    }
    
    enum EmojiTheme: CaseIterable {
        case halloween, animals, food, vehicles, faces, sports
    }
}
