//
//  Concentration.swift
//  Concentration
//
//  Created by John Pospisil on 7/14/18.
//  Copyright © 2018 John Pospisil. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?  { // is nil when no cards are face-up. equals the index of the face-up card otherwise.
        get { // return the calculated value of indexOFOneAndOnlyFaceUpCard
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set { // do something based on the fact that indexOfOneAndOnlyFaceUpCard has changed to a "newValue"
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        // following lines checks to see if the chosen index is in the range of card indices. If not, the crash message below is shown.
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched { // if the card is not matched, do the following ...
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { //If a card different than the face-up card is
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true // turn the card you touched face-up
                
            } else { // else if there is not a face-up card...
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        // following lines checks to see if the numberOfPairsOfCards is greater than 0. If not, the crash message below is shown.
        assert(numberOfPairsOfCards > 0, "Concentration.init(at: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        // Shuffle the cards
        var shuffledCards = [Card]();
        
        for _ in 0..<cards.count
        {
            let rand = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards[rand])
            cards.remove(at: rand)
        }
        
        cards = shuffledCards
        
    }
}
