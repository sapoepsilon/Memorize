//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import SwiftUI

var themeColors: ([String], [Color], String) = ([],[],"")
class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static var theme = Int.random(in: 0...5)


    private static func createMemoryGame() -> MemoryGame<String> {
        
        

        let random: Int = Int.random(in: 2...5)
        let theme = themes()
        let emojis = theme.0
        themeColors = theme
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
    
    
    func score() -> (Int) {
        return model.score
    }
    
    func getTheme() -> ([String], [Color], String) {
        return themeColors
    }
    
    func bonusScore() -> (Int) {
        return model.bonusScore
    }
    
    func negativePoints() -> (Int) {
        return model.negativePoints
    }

    
    
    static func themes() ->  ([String], [Color], String) {
        let random:Int = Int.random(in: 0...5)
        let animals = (["🐂", "🦩", "🐇", "🦥", "🐩", "🦉"], [Color.clear, Color.yellow], "Animals")
        let birds = (["🕊", "🦢", "🐔", "🦜", "🦅", "🦆"], [Color.orange, Color.yellow], "Birds")
        let christmas = (["🎅", "🎄", "🤶🏿", "❄️", "🎁", "☃️"], [Color.red, Color.green], "Christmas")
        let fish = (["🐠", "🐋", "🐳", "🦭", "🦈", "🐟"], [Color.blue, Color.green], "Fish")
        let mammals = (["🦧", "🐒", "🦍", "🦝", "🦨", "🦫"], [Color.pink, Color.purple], "Mammals")
        let shapes = (["🔴", "🟡", "⬜️", "🔷", "🟫", "🔵"], [Color.red, Color.gray], "Shapes")
                
       
        
        let emojis = [animals, birds, christmas, fish, mammals, shapes]

       
        return emojis[random]
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
