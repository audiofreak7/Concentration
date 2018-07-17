//
//  ViewController.swift
//  Concentration
//
//  Created by John Pospisil on 7/14/18.
//  Copyright © 2018 John Pospisil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    private(set) var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
        
    }
    // TODO: Implement the Start Over button functionality
    @IBAction private func touchStartOver(_ sender: UIButton) {
        flipCount = 0
        score = 0
        emojiChoices = ["👻","🐲","💀","👽","👹","👾","🎃","💩","🤡"]
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        updateViewFromModel()
        
    }
    
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.987544477, green: 0.6673021317, blue: 0, alpha: 0) : #colorLiteral(red: 0.987544477, green: 0.6673021317, blue: 0, alpha: 1) // not sure what this syntax means
            }
        }
    }
    
    private var emojiChoices = ["👻","🐲","💀","👽","👹","👾","🎃","💩","🤡"]
    
    private var emoji = [Int: String]() // create a Dictionary called 'emoji'
    
    private func  emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?" // if there is a value for the card's emoji, return it. Otherwise, return '?'
    }
}

// An extension of int that adds a method to return a random int that is less than the int you send
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if  self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
























