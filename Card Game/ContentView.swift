//
//  ContentView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct ContentView: View {
    
    var emojis: Array<String> = ["🚒", "✈️", "🚲", "🚊", "🚠", "🛵", "🚅","🛶", "🚀", "⛵️", "🛺", "🛸", "🚇", "🚂", "🚜", "🦽", "🚞", "🛳", "🚘", "🚟", "🚃", "🏍", "🛴", "🛻"];
    
    @State var emojiCount: Int = 5;
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
            Spacer()
            HStack {
                remove;
                Spacer();
                add;
               
            }.padding(20)
        }
        .padding(.horizontal)

    }
    
    var remove: some View {
        Button {
            emojiCount = max(emojiCount - 1, 1)
        } label: {
            Image(systemName: "minus.circle")
        };
    }
    
    var add: some View {
        Button {
            emojiCount = min(emojiCount + 1, emojis.count - 1)
        } label: {
            Image(systemName: "plus.circle")
        };
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
            .preferredColorScheme(.light)
    }
}
