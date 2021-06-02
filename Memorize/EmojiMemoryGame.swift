//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: EmojiMemoryTheme

    init(theme: EmojiMemoryTheme? = nil) {
        self.theme = theme ?? ThemeDocument().returnedEmoji.randomElement()!
        let emoji = self.theme.emoji.shuffled()
        model = MemoryGame(numberOfPairsOfCards: self.theme.numberOfPairs) { emoji[$0] }
    }
    

    func score() -> (Int) {
        return model.score
    }
    
    
    func setEmoji(game theme: EmojiMemoryTheme) {
        self.theme = theme
    }
    
    func getTheme() -> EmojiMemoryTheme {
        
        return  self.theme
    }
    
    func bonusScore() -> (Int) {
        return model.bonusScore
    }
    
    func negativePoints() -> (Int) {
        return model.negativePoints
    }
    
    
    // MARK: - Acceass to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card:  MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        let emoji = theme.emoji.shuffled()

        model = MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs, cardContentFactory:  { emoji[$0] })
    }
    

    
}

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
