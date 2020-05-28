//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent, ColorType> where CardContent: Equatable {
    var cards: Array<Card>
    var theme: Theme
    private(set) var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(theme: Theme) {
        cards = Array<Card>()
        let numberOfPairsOfCards = theme.numCardPairs ?? Int.random(in: 2..<theme.contents.count)
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = theme.contents[pairIndex % theme.contents.count]
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
        self.theme = theme
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                let didMatch: Bool = cards[chosenIndex].content == cards[potentialMatchIndex].content
                if didMatch {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
                adjustScore(didMatch, involving: chosenIndex, and: potentialMatchIndex)
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func adjustScore(_ didMatch: Bool, involving card1Idx: Int, and card2Idx: Int) {
        if didMatch {
            score += 2
        } else {
            if cards[card1Idx].seen {
                score -= 1
            }
            if cards[card2Idx].seen {
                score -= 1
            }
        }
        cards[card1Idx].seen = true
        cards[card2Idx].seen = true
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent
    }
    
    struct Theme {
        var name: String
        var contents: [CardContent]
        var numCardPairs: Int?
        var color: ColorType
    }
}
