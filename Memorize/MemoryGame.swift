//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    var score: Int
    private var indexOfOneAndTheOnlyOneFaceUp: Int? {
        get { cards.indices.filter{cards[$0].isFaceUp}.only }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {

        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched
        {
            print (cards[chosenIndex].hasSeen, cards[chosenIndex].id)
            if let potentialMatchIndex = indexOfOneAndTheOnlyOneFaceUp {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                    print("score\(score)")
                                        
                } else {
                    for pair in cards.indices {
                        //loop through all the cards find the chosen card, and increment has seen variable
                        if (cards[pair].content == cards[chosenIndex].content || cards[pair].content == cards[indexOfOneAndTheOnlyOneFaceUp!].content) {
                        cards[pair].hasSeen += 1 //MARK : Make it more readable
                        }
                    }
                        calculateSeenCards(card: cards[chosenIndex].hasSeen)
                        calculateSeenCards(card: cards[indexOfOneAndTheOnlyOneFaceUp!].hasSeen )
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfOneAndTheOnlyOneFaceUp = chosenIndex
            }
        }
    }
    
    mutating func calculateSeenCards(card: Int) {
        if(card > 1){
        score -= 1
        print ("Negative\(score)")
        }
    }

    
    init (numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
            cards.shuffle()
        }
        score = 0
     
        
    }
    

    

    struct Card : Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var hasSeen: Int = 0
    }
}
