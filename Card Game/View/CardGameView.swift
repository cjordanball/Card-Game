//
//  CardGameView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var cardGame: EmojiCardGame;
    
    var body: some View {
        ScrollView {
            LazyVGrid (columns: [GridItem(.adaptive(minimum: DrawingConstants.minimumCardWidth))], spacing: DrawingConstants.cardSpacing) {
                ForEach(cardGame.cards){ card in
                    CardView(card: card)
                        .aspectRatio(DrawingConstants.aspectRatio, contentMode: .fit)
                        .onTapGesture {
                            cardGame.choose(card);
                        }
                }

            }.foregroundColor(DrawingConstants.cardColor);
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiCardGame.Card
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius);
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.borderWidth);
                    Text(card.content).font(font(in: geo.size));
                } else if card.isMatched {
                    shape.opacity(DrawingConstants.shading)
                } else {
                    shape.fill(DrawingConstants.cardColor)
                }
            }
        }
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.height, size.width) * DrawingConstants.emojiScale);
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiCardGame();
        CardGameView(cardGame: game)
            .preferredColorScheme(.light)
    }
}
