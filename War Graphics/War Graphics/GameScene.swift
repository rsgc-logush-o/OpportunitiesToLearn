//
//  GameScene.swift
//  War Graphics
//
//  Created by Student on 2016-12-15.
//  Copyright © 2016 Student. All rights reserved.
//

import SpriteKit
import Cocoa
import Foundation


struct Card {
    
    var value : Int
    var suit : Int
    
    // Initializer accepts arguments to set up this instance of the struct
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}

enum Suit : String {
    
    case hearts     = "❤️"
    case diamonds   = "♦️"
    case spades     = "♠️"
    case clubs      = "♣️"
    
    // Given a value, returns the suit
    static func glyph(forHashValue : Int) -> String {
        switch forHashValue {
        case 0 :
            return Suit.hearts.rawValue
        case 1 :
            return Suit.diamonds.rawValue
        case 2 :
            return Suit.spades.rawValue
        case 3 :
            return Suit.clubs.rawValue
        default:
            return Suit.hearts.rawValue
        }
    }
    
}


class GameScene: SKScene {
    
    var playerHand : [Card] = []
    var computerHand : [Card] = []
    
    // Set up the scene
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.green
        
        // Create an enumeration for the suits of a deck of cards
        
        // Play with the enumeration a bit to see what it gives us
        
        
        // Create a new datatype to represent a playing card
        
        var cards = Array(repeating: Array(repeating: "", count: 13), count: 4)
        
        for index in 0...3
        {
            for i in 0...12
            {
                let characterToAdd = 0x1F0A1 + index * 16 + i
            }
        }
        
        

        
        // Initalize a deck of cards
        var deck : [Card] = []
        for suit in 0...3 {
            for value in 0...12 {
                var card = Card(value: value, suit: suit)
                deck.append(card)
            }
        }
        
        // Iterate over the deck of cards
        for card in deck {
            print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
        }
        
        // Initialize hands
        
        
        // "Shuffle" the deck and give half the cards to the player
        while deck.count > 26 {
            
            // Generate a random number between 0 and the count of cards still left in the deck
            var position = Int(arc4random_uniform(UInt32(deck.count)))
            
            // Copy the card in this position to the player's hand
            playerHand.append(deck[position])
            
            // Remove the card from the deck for this position
            deck.remove(at: position)
            
        }
        
        while deck.count > 0 {
            
            var position = Int(arc4random_uniform(UInt32(deck.count)))
            
            computerHand.append(deck[position])
            
            deck.remove(at: position)
        }
        
        // Iterate over the player's hand
        print("=====================================")
        print("All cards in the player's hand are...")
        for (value, card) in playerHand.enumerated() {
            print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
        }
        
        print("=====================================")
        print("All cards in the dealer's hand are...")
        for (value, card) in computerHand.enumerated() {
            print("Card \(value) in dealer's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
        }
       
    }
    
    func cardToUnicode(card: Card) -> String {
        
        let cardToReturn = 0x1F0A1 + card.suit * 16 + card.value
        
        let returnedCard = UnicodeScalar(cardToReturn)
        
        return String(Character(returnedCard!))
        
    }

    
    func showCards(playerCard: Card, dealerCard: Card)
    {
        let player = SKLabelNode(fontNamed: "Helvetica")
        let dealer = SKLabelNode(fontNamed: "Helvetica")
        
        player.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 8)
        dealer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 8)
        
        player.fontSize = 100
        dealer.fontSize = 100
        
        player.text = cardToUnicode(card: playerCard)
        dealer.text = cardToUnicode(card: dealerCard)
        
        self.addChild(player)
        self.addChild(dealer)
        
        
        
    }
        // Responds to first touch point
    
    
    override func mouseDown(with event: NSEvent)
    {
        print("yes")
        playATurn()
    }

    
    // Responds to touch "drag"
    
    
    func playATurn()
    {
        var gameIsOn = true
        
        
            print("=====================================")
            
            var playersCard = playerHand[0]
            var computersCard = computerHand[0]
            
            playerHand.remove(at: 0)
            computerHand.remove(at: 0)
            
            showCards(playerCard: playersCard, dealerCard: computersCard)
            
            print("The dealer's card is a \(computersCard.value) of \(Suit.glyph(forHashValue: computersCard.suit))")
            
            print("The player's card is a \(playersCard.value) of \(Suit.glyph(forHashValue: playersCard.suit))")
            
            if playersCard.value > computersCard.value
            {
                print("The player wins!")
                playerHand.append(computersCard)
                playerHand.append(playersCard)
                
            }else if computersCard.value > playersCard.value
            {
                print("The dealer wins!")
                computerHand.append(computersCard)
                computerHand.append(playersCard)
                
            }else if computersCard.value == playersCard.value
            {
                print("War")
                var playersUnknownCard = playerHand[0]
                playerHand.remove(at: 0)
                
                var playersKnownCard = playerHand[0]
                playerHand.remove(at: 0)
                
                var computersUnknownCard = computerHand[0]
                computerHand.remove(at: 0)
                
                var computersKnownCard = computerHand[0]
                computerHand.remove(at: 0)
                
                print("The dealer's card is a \(computersKnownCard.value) of \(Suit.glyph(forHashValue: computersKnownCard.suit))")
                
                print("The player's card is a \(playersKnownCard.value) of \(Suit.glyph(forHashValue: playersKnownCard.suit))")
                
                if playersKnownCard.value > computersKnownCard.value
                {
                    print("The player wins the war!")
                    playerHand.append(computersCard)
                    playerHand.append(playersCard)
                    playerHand.append(computersUnknownCard)
                    playerHand.append(playersUnknownCard)
                    playerHand.append(computersKnownCard)
                    playerHand.append(playersKnownCard)
                }else if computersKnownCard.value > playersKnownCard.value
                {
                    print("The dealer wins the war!")
                    computerHand.append(computersCard)
                    computerHand.append(playersCard)
                    computerHand.append(computersUnknownCard)
                    computerHand.append(playersUnknownCard)
                    computerHand.append(computersKnownCard)
                    computerHand.append(playersKnownCard)
                }
                
            }
            
            sleep(1)
            
            if playerHand.count == 0 || computerHand.count == 0
            {
                gameIsOn = false
            }
        
    }
    
    
    
    
}
