//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ismatulla Mansurov on 3/1/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>

    var bonusScore: Int
    var negativePoints: Int
    var score: Int
    private var indexOfOneAndTheOnlyOneFaceUp: Int? {
        get { cards.indices.filter{cards[$0].isFaceUp}.only }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
                bonusScore = 0
                
                
            }
        }
    }
    
    mutating func choose(card: Card) {
        
        
        
        
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOneAndTheOnlyOneFaceUp {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    if(card.bonusTimeRemaining > 4) {
                        score += 8
                        bonusScore = 8
                        negativePoints = 0
                    } else if( card.bonusRemaining <= 4 && card.bonusTimeRemaining > 2) {
                        score += 6
                        bonusScore = 6
                        negativePoints = 0
                    } else if(card.bonusRemaining <= 2 && card.bonusTimeRemaining > 0) {
                        score += 4
                        bonusScore = 4
                        negativePoints = 0
                    } else {
                        score += 2
                        bonusScore = 2
                        negativePoints = 0
                    }
                    
                } else {
                    for pair in cards.indices {
                        
                        //loop through all the cards find the chosen card, and increment the hasSeen variable
                        if (cards[pair].content == cards[chosenIndex].content || cards[pair].content == cards[indexOfOneAndTheOnlyOneFaceUp!].content) {
                            cards[pair].hasSeen += 1 //MARK : Make it more readable
                        }
                    }
                    calculateSeenCards(card: cards[chosenIndex].hasSeen)
                    calculateSeenCards(card: cards[indexOfOneAndTheOnlyOneFaceUp!].hasSeen )
                    
                    if card.hasSeen > 2 {
                        negativePoints = -2
                    }
                }
                
                self.cards[chosenIndex].isFaceUp = true
                
            } else {
                indexOfOneAndTheOnlyOneFaceUp = chosenIndex
            }
        }
    }
    
    mutating func calculateSeenCards(card: Int) {
        if(card > 1 && card < 2){
            score -= 1
            negativePoints = -1
            
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
        bonusScore = 0
        negativePoints = 0
        
    }
    
    
    
    
    struct Card : Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var hasSeen: Int = 0
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // MARK: - Bonus Time
        
        //get matchong bonus points
        // if the user matches card
        // before a certain amount of time passes during which the card is face up
        
        //can be zero which means //" no bonus points"
        
        var bonusTimeLimit: TimeInterval = 6
        
        // how long the card has been Faced up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        //the accumulated time this card has been face up in the past
        // (i.e. not includeing the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        //percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        //whether the card earned bonus during the bonus time
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        

        
        //called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // Called when the card goes back face down (or goes matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
