//
//  Card_GameApp.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

@main

struct Card_GameApp: App {
    let game = EmojiCardGame();
    var body: some Scene {
        WindowGroup {
            ContentView(cardGame: game)
        }
    }
}
