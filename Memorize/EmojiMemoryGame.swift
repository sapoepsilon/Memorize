//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static var theme = Int.random(in: 0...5)


    private static func createMemoryGame() -> MemoryGame<String> {
        
        

        let random: Int = Int.random(in: 2...5)
        let emojis = themes().first!.0
    
        if(emojis.description.contains("🎄")) {
        return MemoryGame<String>(numberOfPairsOfCards: random) {
            pairIndex in
            return emojis[pairIndex]
        }
        } else {
            return MemoryGame<String>(numberOfPairsOfCards: 5) {
                pairIndex in
                return emojis[pairIndex]
            }
        }
    }
    
    var themes = themes()
    
    func score() -> (Int) {
        return model.score
    }

    
    
    static func themes() ->  ([([String], [Color], String)]) {
        let animals = (["🐂", "🦩", "🐇", "🦥", "🐩", "🦉"], [Color.black, Color.yellow], "Animals")
        let birds = (["🕊", "🦢", "🐔", "🦜", "🦅", "🦆"], [Color.orange, Color.yellow], "Birds")
        let christmas = (["🎅", "🎄", "🤶🏿", "❄️", "🎁", "☃️"], [Color.red, Color.green], "Christmas")
        let fish = (["🐠", "🐋", "🐳", "🦭", "🦈", "🐟"], [Color.blue, Color.pink], "Fish")
        let mammals = (["🦧", "🐒", "🦍", "🦝", "🦨", "🦫"], [Color.pink, Color.red], "Mammals")
        let shapes = (["🔴", "🟡", "⬜️", "🔷", "🟫", "🔵"], [Color.red, Color.purple], "Shapes")
                
       
        
        let emojis = [animals, birds, christmas, fish, mammals, shapes]

       
        return emojis
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
        model = EmojiMemoryGame.createMemoryGame()
    }

}
