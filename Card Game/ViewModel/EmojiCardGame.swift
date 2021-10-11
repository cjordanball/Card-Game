//
//  EmojiCardGame.swift
//  Card Game
//
//  Created by BallWebDev on 10/1/21.
//

import SwiftUI

class EmojiCardGame: ObservableObject {
    
    typealias Card = CardGame<String>.Card
    
    private static let emojis = ["🚒", "✈️", "🚲", "🚊", "🚠", "🛵", "🚅","🛶", "🚀", "⛵️", "🛺", "🛸", "🚇", "🚂", "🚜", "🦽", "🚞", "🛳", "🚘", "🚟", "🚃", "🏍", "🛴", "🛻"];
    
    private static func createCardGame() -> CardGame<String> {
        CardGame<String>(numberOfPairsOfCards: 10) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createCardGame();
    
    var cards: Array<Card> {
        model.cards;
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card);
    }
}
