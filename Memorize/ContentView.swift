//
//  ContentView.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 2/22/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        HStack{
            ForEach(viewModel.cards){
                card in CardView(card: card)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
        }
        }.padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
    }
}
struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).aspectRatio( 2/3, contentMode:  .fit)
                Text(card.content)
                
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }.font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK:  --Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.8
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

