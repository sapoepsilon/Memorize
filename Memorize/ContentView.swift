//
//  ContentView.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 2/22/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var isGameStart: Bool = false
  
    
    
    var body: some View {
        let themeColor = viewModel.getTheme().color
        VStack{
            
            Text(self.viewModel.negativePoints() != 0 ? "  \(viewModel.negativePoints())" : "")
                .font(.largeTitle)
                .foregroundColor(Color.red)
                .transition(AnyTransition.scale)
            
            
            Text(self.viewModel.bonusScore() != 0 ? " + \(self.viewModel.bonusScore())" : "")
                .font(.largeTitle)
                .foregroundColor(themeColor)
                .transition(AnyTransition.offset(x: 100, y: 0))
            
                VStack{
                    if isGameStart {
                    startGame()
                }
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
            
        }.onAppear(){
            isGameStart.toggle()
        }
    }
    
    func startGame() -> some View {
        
        return Grid(viewModel.cards){card in
            CardView(card: card, viewModel: viewModel)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                        self.viewModel.choose(card: card)
                        
                    }
                }
                .padding(5)
        }.padding()
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
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-animatedBonusRemaining*360-90), clockwise: true).foregroundColor(viewModel.getTheme().color)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    }
                    else {
                        Pie(startAngle: .degrees(0-90), endAngle: .degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                .transition(.identity)

                Text(card.content)
                    .font(fontSize(for: size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, themeColor: viewModel.getTheme().color)
            .transition(AnyTransition.scale)
        }
    }
    
    
    // MARK:  --Drawing Constants
    
    private let fontScaleFactor: CGFloat = 0.8
   
    private func fontSize(for size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
}


