//
//  ContentView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct ContentView: View {
    let cardGame: EmojiCardGame;
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 75))], spacing: 15) {
                    ForEach(cardGame.cards){ card in
                        CardView(card: card)
                            .aspectRatio(0.67, contentMode: .fit)
                    }
                }.foregroundColor(.red)
            }
        }
        .padding(.horizontal)

    }
}

struct CardView: View {
    let card: CardGame<String>.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3);
                Text(card.content).font(.largeTitle);
            } else {
                shape.fill(.red)
            }
        }

    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiCardGame();
        ContentView(cardGame: game)
            .preferredColorScheme(.dark)
        ContentView(cardGame: game)
            .preferredColorScheme(.light)
    }
}
