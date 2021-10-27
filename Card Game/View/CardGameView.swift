//
//  CardGameView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct CardGameView: View {
    @ObservedObject var cardGame: EmojiCardGame;
    
    @Namespace private var dealingNamespace;
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    shuffle
                    Spacer()
                    restart
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding(.horizontal)
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiCardGame.Card) {
        dealt.insert(card.id);
    }
    
    private func isUndealt(_ card: EmojiCardGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiCardGame.Card) -> Animation {
        var delay = 0.0;
        if let index = cardGame.cards.firstIndex(where: { $0.id == card.id }) {
            delay = 2.0 * Double(index) * (DrawingConstants.dealDuration / Double(cardGame.cards.count))
        }
        return Animation.easeInOut(duration: DrawingConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiCardGame.Card) -> Double {
        -Double(cardGame.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: cardGame.cards, aspectRatio: DrawingConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear;
            } else {
            CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(
                    insertion: .identity,
                    removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        cardGame.choose(card);
                    }
                }
            }
        }
        .foregroundColor(DrawingConstants.cardColor)
    }
    
    var deckBody: some View {
        ZStack{
            ForEach(cardGame.cards.filter (isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                    .zIndex(zIndex(of: card));
            }
        }
        .frame(width: DrawingConstants.undealtWidth, height: DrawingConstants.undealtHeight)
        .foregroundColor(DrawingConstants.cardColor)
        .onTapGesture {
            for card in cardGame.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(Animation.easeInOut(duration: 1)) {
                cardGame.shuffle();
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = [];
                cardGame.restart();
            }
        }
    }
}

struct CardView: View {
    let card: EmojiCardGame.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees:0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining;
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees:0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                    .opacity(0.5)
                    .padding(DrawingConstants.timerCirclePadding);
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0.0))
                    .animation(Animation.interactiveSpring(response: 2.0, dampingFraction: 0.4, blendDuration: 2.0).delay(0.2))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geo.size))
            }
        }.cardify(isFaceUp: card.isFaceUp);
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        let width = max(0.01, size.width);
        let height = max(0.01, size.height);
        let sizeConst = DrawingConstants.emojiScale / DrawingConstants.fontSize;
        return min(height, width) * sizeConst;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiCardGame();
        game.choose(game.cards.first!);
        return CardGameView(cardGame: game)
            .preferredColorScheme(.light)
    }
}
