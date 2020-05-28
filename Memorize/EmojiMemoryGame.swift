//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var game: MemoryGame<String, Color> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String, Color> {
        return MemoryGame<String, Color>(theme: getRandomTheme())
    }
    
    // MARK: - Accessors
    
    var cards: Array<MemoryGame<String, Color>.Card> {
        game.cards
    }
    
    var theme: MemoryGame<String, Color>.Theme {
        game.theme
    }
    
    var score: Int {
        game.score
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String, Color>.Card) {
        game.choose(card)
    }
    
    func newGame() {
        game = EmojiMemoryGame.createMemoryGame()
    }
    
    // MARK: - Themes
    
    private static func getRandomTheme() -> MemoryGame<String, Color>.Theme {
        let theme = EmojiTheme.allCases.randomElement()!
        switch theme {
        case .halloween:
            let contents = ["👻", "🕷", "🕸", "🎃", "🧛🏻‍♀️"]
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
