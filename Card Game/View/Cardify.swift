//
//  Cardify.swift
//  Card Game
//
//  Created by BallWebDev on 10/16/21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double;
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0.0 : 180;
    }
    
    var animatableData: Double {
        get { rotation }
        set {
            rotation = newValue;
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius);
            if rotation < 90 {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.borderWidth);
            } else {
                shape.fill(DrawingConstants.cardColor)
            }
            content
                .opacity(rotation < 90 ? 1 : 0.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0.0, y: 1, z: 0),  perspective: 1.5)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
