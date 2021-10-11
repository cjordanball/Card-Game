//
//  Card_GameApp.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

@main

struct Card_GameApp: App {
    private let game = EmojiCardGame();
    var body: some Scene {
        WindowGroup {
            CardGameView(cardGame: game)
        }
    }
}
