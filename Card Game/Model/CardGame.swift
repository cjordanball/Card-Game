//
//  CardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import Foundation

struct CardGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>();
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex);
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    struct Card {
        var isFaceUp: Bool = false;
        var isMatched: Bool = false;
        var content: CardContent
    }
}
