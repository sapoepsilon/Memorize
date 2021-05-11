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
   
                
            Text(self.viewModel.negativePoints() != 0 ? "  \(viewModel.negativePoints())" : "")
                .font(.largeTitle)
                .foregroundColor(Color.red)
                .transition(AnyTransition.scale)
            
            
                Text(self.viewModel.bonusScore() != 0 ? " + \(self.viewModel.bonusScore())" : "")
                    .font(.largeTitle)
                    .foregroundColor(viewModel.getTheme().1.last)
                    .transition(AnyTransition.offset(x: 100, y: 0))
            ZStack{
                
            Grid(viewModel.cards){
                card in CardView(card: card, viewModel: viewModel)

                    .onTapGesture {
                        withAnimation(.linear(duration: 0.5)) {
                            self.viewModel.choose(card: card)

                        
                        }
                                                                 

                    }
            
                    .padding(5)
            }.padding()


            
            }
            Text("Score \(viewModel.score())").fontWeight(.bold).font(Font.largeTitle).foregroundColor(themeColor)
            
        
      
            Button(action:{
                withAnimation(.easeInOut) {
                    viewModel.newGame()
                }
            }, label: {
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
    
    @State private var animatedBonusRemaining: Double = 0
    @State private var bonusScore: Double = 0
    @State private var isEarnedBonus: Bool = false
    
    private func startBonusTimeAnimation() {
        
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0

        }
        bonusScore = card.bonusTimeRemaining
    }
    
    private func toggleBonusScore() {
        isEarnedBonus.toggle()
    }


    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90)).fill(LinearGradient(gradient: Gradient(colors:  viewModel.getTheme().1), startPoint: .bottom, endPoint: .center))
                            .onAppear() {
                                self.startBonusTimeAnimation()
                                self.isEarnedBonus = false
                            }
                    }
                    else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90)).fill(LinearGradient(gradient: Gradient(colors:  viewModel.getTheme().1), startPoint: .bottom, endPoint: .center))
                  
                    }

                }
                .opacity(0.4)
                .padding(5)

                
                Text(card.content).font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.5).repeatForever(autoreverses: false) : .default)
             
//                Text("Score")
//                    .transition(card.isMatched ? AnyTransition.offset(x: 0, y: 1000) : .identity)
//                    .opacity(card.isMatched ? 1 : 0)
   
    
            }
            .cardify(isFaceUp: card.isFaceUp, themeColor: viewModel.getTheme().1)
            .transition(AnyTransition.scale)

        }
    }
 
    
    // MARK:  --Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.8
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}


