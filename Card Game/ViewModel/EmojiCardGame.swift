//
//  EmojiCardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import SwiftUI

class EmojiCardGame: ObservableObject {
    
    private static let emojis: Array<String> = ["🚒", "✈️", "🚲", "🚊", "🚠", "🛵", "🚅","🛶", "🚀", "⛵️", "🛺", "🛸", "🚇", "🚂", "🚜", "🦽", "🚞", "🛳", "🚘", "🚟", "🚃", "🏍", "🛴", "🛻"];
    
    private static func createCardGame() -> CardGame<String> {
        CardGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createCardGame();
    
    var cards: Array<CardGame<String>.Card> {
        model.cards;
    }
    
    // MARK: - Intent(s)
    func choose(_ card: CardGame<String>.Card) {
        model.choose(card);
    }
}
