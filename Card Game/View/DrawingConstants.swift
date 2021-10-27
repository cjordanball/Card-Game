//
//  DrawingConstants.swift
//  Card Game
//
//  Created by BallWebDev on 10/5/21.
//

import Foundation
import SwiftUI

struct DrawingConstants {
    static let cornerRadius: CGFloat = 20;
    static let minimumCardWidth: CGFloat = 80;
    static let cardSpacing: CGFloat = 10;
    static let aspectRatio: CGFloat = 0.67;
    static let borderWidth: CGFloat = 3.0;
    static let shading: Double = 0.5;
    static let cardColor: Color = .blue;
    static let emojiScale: CGFloat = 0.75;
    static let timerCirclePadding: CGFloat = 5;
    static let fontSize: CGFloat = 32;
    static let undealtHeight: CGFloat = 90;
    static let undealtWidth = undealtHeight * aspectRatio;
    static let dealDuration: CGFloat = 0.5;
    static let bonusInterval: TimeInterval = 6;
}
