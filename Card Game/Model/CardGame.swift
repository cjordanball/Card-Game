//
//  CardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import Foundation

struct CardGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true;
                    cards[potentialMatchIndex].isMatched = true;
                }
                indexOfOnlyFaceUpCard = nil;
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false;
                }
                indexOfOnlyFaceUpCard = chosenIndex;
            }
            cards[chosenIndex].isFaceUp.toggle();
        };
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex);
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle();
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false;
        var isMatched: Bool = false;
        let content: CardContent;
        let id: Int;
        
        
        
    }
}
