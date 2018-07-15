//
//  ViewController.swift
//  Concentration
//
//  Created by John Pospisil on 7/14/18.
//  Copyright © 2018 John Pospisil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
        
    }
    
    func  updateViewFromModel() {
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
    
    var emojiChoices = ["👻","🐲","💀","👽","👹","👾","🎃","💩","🤡"]
    
    var emoji = [Int: String]() // create a Dictionary called 'emoji'
    
    func  emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?" // if there is a value for the card's emoji, return it. Otherwise, return '?'
    }
}

























