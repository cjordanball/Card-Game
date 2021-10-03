//
//  EmojiCardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import SwiftUI

class EmojiCardGame: ObservableObject {
    
    static let emojis: Array<String> = ["🚒", "✈️", "🚲", "🚊", "🚠", "🛵", "🚅","🛶", "🚀", "⛵️", "🛺", "🛸", "🚇", "🚂", "🚜", "🦽", "🚞", "🛳", "🚘", "🚟", "🚃", "🏍", "🛴", "🛻"];
    
    static func createCardGame() -> CardGame<String> {
        CardGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: CardGame<String> = createCardGame();
    
    var cards: Array<CardGame<String>.Card> {
        model.cards;
    }
    
    // MARK: - Intent(s)
    func choose(_ card: CardGame<String>.Card) {
        model.choose(card);
    }
}
