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
        let themeColor = viewModel.getTheme().1.last
        VStack{
            HStack{
                Text("Theme: \(viewModel.getTheme().2)").foregroundColor(themeColor).font(Font.headline)
            }
                Grid(viewModel.cards){
                    card in CardView(card: card, viewModel: viewModel)
                        .onTapGesture {
                            self.viewModel.choose(card: card)
                        }
                        .padding(5)
                }.padding()
               
            Text("Score \(viewModel.score())").fontWeight(.bold).font(Font.largeTitle).foregroundColor(themeColor)

                Button(action:{
                    
                        viewModel.newGame()},
                       label: {
                        Text("New Game")
                       })
                    .padding()
                    .background(themeColor)
                    .cornerRadius(23)
                    .foregroundColor(Color.white)
        }
    }
}
    

struct CardView: View {
    var card: MemoryGame<String>.Card
    var viewModel: EmojiMemoryGame
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
        ZStack {
      
            Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110-90)).fill(LinearGradient(gradient: Gradient(colors:  viewModel.getTheme().1), startPoint: .bottom, endPoint: .center))
            Text(card.content).font(Font.system(size: fontSize(for: size))).transition(.scale)
            
        }.cardify(isFaceUp: card.isFaceUp, themeColor: viewModel.getTheme().1)

        }
    }
        

        
    
    
    // MARK:  --Drawing Constants
    

    private let fontScaleFactor: CGFloat = 0.8
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

func themeColor() {
    
}

