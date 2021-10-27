//
//  CardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import Foundation

struct CardGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfOnlyFaceUpCard: Int? {
        let cardsShowingIndices = cards.indices.filter{ cards[$0].isFaceUp }
        return cardsShowingIndices.count == 1 ? cardsShowingIndices.first! : nil;
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                }
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false;
                }
            }
            cards[chosenIndex].isFaceUp.toggle();
        };
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [];
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex);
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle();
        
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonustime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                print("isMatched")
                stopUsingBonusTime()
            }
        }
        let content: CardContent;
        let id: Int;
    
        // MARK: - Bonus Time
         
        // this can be adjusted
        var bonusTimeLimit = DrawingConstants.bonusInterval;
        
        // determine how long the card has been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate);
            } else {
                return pastFaceUpTime;
            }
        }
        // the last time the card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // cumulative amount of time the card has been face up in the past
        var pastFaceUpTime: TimeInterval = 0;
        
        // how much time left before bonus time runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0;
        }
        // whether the card is matched during the bonus period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0;
        }
        // whether card is currently face up, unmatched, and bonus time still remains
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0;
        }
        
        // called when the card transitions to face up
        private mutating func startUsingBonustime() {
            if isConsumingBonusTime, lastFaceUpDate  == nil {
                lastFaceUpDate = Date();
            }
        }
        // called when the card goes face down, or is matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime;
            self.lastFaceUpDate = nil;
        }
    }
}
