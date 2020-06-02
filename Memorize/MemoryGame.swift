//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jonas Müller on 19.05.20.
//  Copyright © 2020 compitencies. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    var isFinished: Bool {
        cards.filter { $0.isMatched }.count == cards.count
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        guard !card.isFaceUp else { return }
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
    
    private mutating func adjustScore(_ didMatch: Bool, involving card1Idx: Int, and card2Idx: Int) {
        score += didMatch ? 2 : -(cards.filter { $0.seen && ($0.id == cards[card1Idx].id || $0.id == cards[card2Idx].id)  }.count)
        cards[card1Idx].seen = true
        cards[card2Idx].seen = true
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var seen: Bool = false
        var content: CardContent
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
