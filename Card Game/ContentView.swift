//
//  ContentView.swift
//  Card Game
//
//  Created by BallWebDev on 9/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView();
            CardView(isFaceUp: false);
            CardView(isFaceUp: false);
            CardView();
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
}

struct CardView: View {
    
    @State var isFaceUp: Bool = true;
 
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20);
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.stroke(lineWidth: 3);
                Text("✈️")
                    .font(.largeTitle)
            } else {
                shape.fill(.red)
            }
        }
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
