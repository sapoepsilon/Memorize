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

                Grid(viewModel.cards){
                    card in CardView(card: card)
                        .onTapGesture {
                            self.viewModel.choose(card: card)
                        }
                        .padding(5)
                }.padding()
                
                Button(action:{
                    
                        viewModel.newGame()},
                       label: {
                        Text("New Game")
                       })
            
        }
}
    

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke( lineWidth: edgeLineWidth).aspectRatio( 2/3, contentMode:  .fit)
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110-90)).fill()
                Text(card.content)
                
            } else {
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }.font(Font.system(size: fontSize(for: size)))

        
    }
    
    // MARK:  --Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
    private let fontScaleFactor: CGFloat = 0.8
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

