//
//  ContentView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State var emojiCount: Int = 20;
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 75))], spacing: 15) {
                    ForEach(emojis[0..<emojiCount], id: \.self){
                        emoji in
                        CardView(content: emoji);
                    }
                }.foregroundColor(.red)
            }
        }
        .padding(.horizontal)

    }
}



struct CardView: View {
    var content: String;
    @State var isFaceUp: Bool = true;
 
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3);
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill(.red)
            }
        }
        .aspectRatio(0.67, contentMode: .fit)
        .onTapGesture {
            isFaceUp = !isFaceUp;
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}