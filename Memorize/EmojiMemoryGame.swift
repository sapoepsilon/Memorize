//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
   @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🦍", "🦩", "🐇", "🦥", "🦦"]
        let random = Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards: random) {
            pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Acceass to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
    }
    
    // MARK: - Intent(s)
    
    func choose(card:  MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
