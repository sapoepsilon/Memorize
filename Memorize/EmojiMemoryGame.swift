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

        let random: Int = Int.random(in: 2...5)
        
        
        func emojis() -> [String] {
            let animals = ["🐂", "🦩", "🐇", "🦥", "🐩", "🦉"]
            let birds = ["🕊", "🦢", "🐔", "🦜", "🦅", "🦆"]
            let christmas = ["🎅", "🎄", "🤶🏿", "❄️", "🎁", "☃️"]
            let fish = ["🐠", "🐋", "🐳", "🦭", "🦈", "🐟"]
            let apes = ["🦧", "🐒", "🦍", "🦝", "🦨", "🦫"]
            let shapes = ["🔴", "🟡", "⬜️", "🔷", "🟫", "🔵"]
            
            let emojis = [animals, birds, christmas, fish, apes, shapes]
            let randomTheme: Int = Int.random(in: 0...4)
            print(randomTheme)
            
            return emojis[randomTheme]
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: random) {
            pairIndex in
            return emojis()[pairIndex]
        }
    }
    
    // MARK: - Acceass to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card:  MemoryGame<String>.Card) {
        model.choose(card: card)
    }

}
