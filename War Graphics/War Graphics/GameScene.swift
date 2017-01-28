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

//This is the structure to hold the information for individual cards
struct Card {
    
    //These two values are what describe the card
    var value : Int
    var suit : Int
    
    //Initializes the Card
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}


//This returns the unicode character for the suit given the value from a card
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
    
    //These arrays hold all of the cards for the player and dealer
    var playerHand : [Card] = []
    var computerHand : [Card] = []
    
    var playerWarHand : [Card] = []
    var computerWarHand : [Card] = []
    
    //These are the graphics nodes for the player and dealer
    var player = SKLabelNode(fontNamed: "Helvetica")
    var dealer = SKLabelNode(fontNamed: "Helvetica")
    
    var playerWar1 = SKLabelNode(fontNamed: "Helvetica")
    var playerWar2 = SKLabelNode(fontNamed: "Helvetica")
    
    var dealerWar1 = SKLabelNode(fontNamed: "Helvetica")
    var dealerWar2 = SKLabelNode(fontNamed: "Helvetica")
    
    //This is the graphic node to display who won
    var winner = SKLabelNode(fontNamed: "Helvetica")
    
    //These display the number of cards in the player and dealers possesion
    var numberOfPlayerCards = SKLabelNode(fontNamed: "Helvetica")
    var numberOfDealerCards = SKLabelNode(fontNamed: "Helvetica")
    
    

    
    // Set up the scene
    override func didMove(to view: SKView) {
        
        //Making the background green like a poker table
        backgroundColor = SKColor.green
        
        
        //This creates the deck of cards to be randomly distributed to the competitors
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
        
        
        // "Shuffle" the deck and give half the cards to the player
        while deck.count > 26 {
            
            // Generate a random number between 0 and the count of cards still left in the deck
            let position = Int(arc4random_uniform(UInt32(deck.count)))
            
            // Copy the card in this position to the player's hand
            playerHand.append(deck[position])
            
            // Remove the card from the deck for this position
            deck.remove(at: position)
            
        }
        
        //Give the rest of the cards to the dealer in random order
        while deck.count > 0 {
    
            let position = Int(arc4random_uniform(UInt32(deck.count)))
            
            computerHand.append(deck[position])
            
            deck.remove(at: position)
        }
        
        // Iterate over the player's hand
        print("=====================================")
        print("All cards in the player's hand are...")
        for (value, card) in playerHand.enumerated() {
            print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
        }
        
        //Iterate over the dealers hand
        print("=====================================")
        print("All cards in the dealer's hand are...")
        for (value, card) in computerHand.enumerated() {
            print("Card \(value) in dealer's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
        }
       
    }
    
    //This function takes a card and returns the unicode symbol for that card
    func cardToUnicode(card: Card) -> String {
        
        let cardToReturn = 0x1F0A1 + card.suit * 16 + card.value
        
        let returnedCard = UnicodeScalar(cardToReturn)
        
        return String(Character(returnedCard!))
        
    }

    
    //This displays the cards on screen
    func showCards(playerCard: Card, dealerCard: Card)
    {
        
        //Clear the previous nodes from the screen
        player.removeFromParent()
        dealer.removeFromParent()
        
        playerWar1.removeFromParent()
        playerWar2.removeFromParent()
        
        dealerWar1.removeFromParent()
        dealerWar2.removeFromParent()
        
        //Setting the position of the cards
        player.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 8)
        dealer.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 4)
        
        //Setting the size of the cards
        player.fontSize = 200
        dealer.fontSize = 200
        
        //Setting the unicode card to be displayed
        player.text = cardToUnicode(card: playerCard)
        dealer.text = cardToUnicode(card: dealerCard)
        
        //Adding the node to the gamescene
        self.addChild(player)
        self.addChild(dealer)
        
        
        
    }
    
    //This shows the cards during a war
    func showCardsForWar(playerWarVisible: Card, playerWarNotVisible: Card, dealerWarVisible: Card, dealerWarNotVisible: Card, playerCard: Card, dealerCard: Card)
    {
        //Clearing any previous cards from the screen
        player.removeFromParent()
        dealer.removeFromParent()
        
        playerWar1.removeFromParent()
        playerWar2.removeFromParent()
        
        dealerWar1.removeFromParent()
        dealerWar2.removeFromParent()
        
        
        //Setting the position of all of the cards
        player.position = CGPoint(x: frame.size.width / 4, y: frame.size.height / 8)
        dealer.position = CGPoint(x: frame.size.width / 4, y: frame.size.height - frame.size.height / 4)
        
        playerWar1.position = CGPoint(x: frame.size.width * 0.45, y : frame.size.height / 8)
        playerWar2.position = CGPoint(x: frame.size.width * 0.6, y : frame.size.height / 8)
        
        dealerWar1.position = CGPoint(x: frame.size.width * 0.45, y : frame.size.height - frame.size.height / 4)
        dealerWar2.position = CGPoint(x: frame.size.width * 0.6, y : frame.size.height - frame.size.height / 4)
        
        //Setting the size for all of the cards
        player.fontSize = 200
        dealer.fontSize = 200
        
        playerWar1.fontSize = 200
        playerWar2.fontSize = 200
        
        dealerWar1.fontSize = 200
        dealerWar2.fontSize = 200
        
        //Setting the unicode symbol to be displayed
        player.text = cardToUnicode(card: playerCard)
        dealer.text = cardToUnicode(card: dealerCard)
        
        playerWar1.text = cardToUnicode(card: playerWarVisible)
        playerWar2.text = "🂠"
        
        dealerWar1.text = cardToUnicode(card: dealerWarVisible)
        dealerWar2.text = "🂠"
        
        //Adding the nodes to the gamescene
        self.addChild(player)
        self.addChild(dealer)
        
        self.addChild(playerWar1)
        self.addChild(playerWar2)
        
        self.addChild(dealerWar1)
        self.addChild(dealerWar2)
        
    }
    
    //This function displays the winner of each round and the number of cards in each opponents hand
    func showInfo(gameWinner: String, playersCards: Int, dealersCards: Int)
    {
        //Clearing the nodes from the screen
        winner.removeFromParent()
        numberOfPlayerCards.removeFromParent()
        numberOfDealerCards.removeFromParent()
        
        //Setting the position of the information to be displayed
        winner.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height/2)
        numberOfPlayerCards.position = CGPoint(x: frame.size.width * 0.90, y: frame.size.height * 0.05)
        numberOfDealerCards.position = CGPoint(x: frame.size.width * 0.10, y: frame.size.height * 0.95)
        
        //Setting the fontsize
        winner.fontSize = 100
        numberOfPlayerCards.fontSize = 25
        numberOfDealerCards.fontSize = 25
        
        //Setting the text to display
        winner.text = "\(gameWinner) Wins!"
        numberOfPlayerCards.text = "Cards: \(playersCards)"
        numberOfDealerCards.text = "Cards: \(dealersCards)"
        
        //Adding the nodes to the gamescene
        self.addChild(winner)
        self.addChild(numberOfPlayerCards)
        self.addChild(numberOfDealerCards)
    }
    
    func playWar()
    {
        for _ in 1...2
            {
               // print("\(i)")
                playerWarHand.append(playerHand[0])
                playerHand.remove(at: 0)
                
                computerWarHand.append(computerHand[0])
                computerHand.remove(at: 0)
            }
        
        showCardsForWar(playerWarVisible: playerWarHand[playerWarHand.count - 2], playerWarNotVisible: playerWarHand[playerWarHand.count - 1], dealerWarVisible: computerWarHand[computerWarHand.count - 2], dealerWarNotVisible: computerWarHand[computerWarHand.count - 1], playerCard: playerWarHand[playerWarHand.count - 3], dealerCard: computerWarHand[computerWarHand.count - 3])
        
        if playerWarHand[playerWarHand.count - 1].value > computerWarHand[computerWarHand.count - 1].value
        {
            for index in 0...playerWarHand.count - 1
            {
                playerHand.append(playerWarHand[0])
                playerWarHand.remove(at: 0)
                
                playerHand.append(computerWarHand[0])
                computerWarHand.remove(at: 0)
            }
            
            showInfo(gameWinner: "Player", playersCards: playerHand.count, dealersCards: computerHand.count)
        }else if playerWarHand[playerWarHand.count - 1].value < computerWarHand[computerWarHand.count - 1].value
        {
            for index in 0...computerWarHand.count - 1
            {
                computerHand.append(computerWarHand[0])
                computerWarHand.remove(at: 0)
                
                computerHand.append(playerWarHand[0])
                playerWarHand.remove(at: 0)
            }
            
            showInfo(gameWinner: "Dealer", playersCards: playerHand.count, dealersCards: computerHand.count)
        }else
        {
            playWar()
        }
    }
    
    
    //Play a turn when the mouse is clicked
    override func mouseDown(with event: NSEvent)
    {
        print("yes")
        playATurn()
    }
    
    //The function plays a turn in the game of war
    func playATurn()
    {
        var gameIsOn = true
        
            //Seperating line for each turn in the console
            print("=====================================")
        
            //These hold the values for the current cards being played
            var playersCard = playerHand[0]
            var computersCard = computerHand[0]
        
            //Removing the card that was just pulled from each hand
            playerHand.remove(at: 0)
            computerHand.remove(at: 0)
        
            //This shows the cards on the screen
            showCards(playerCard: playersCard, dealerCard: computersCard)
        
            //This prints to the console the value of the cards
            print("The dealer's card is a \(computersCard.value + 1) of \(Suit.glyph(forHashValue: computersCard.suit))")
            
            print("The player's card is a \(playersCard.value + 1) of \(Suit.glyph(forHashValue: playersCard.suit))")
        
            //Checking who won or if it is tied do a war
            if playersCard.value > computersCard.value
            {
                print("The player wins!")
                
                //Add the two cards in contest to the players hand
                playerHand.append(computersCard)
                playerHand.append(playersCard)
                
                //Show the info at the end of the turn
                showInfo(gameWinner: "Player", playersCards: playerHand.count, dealersCards: computerHand.count)
                
            }else if computersCard.value > playersCard.value
            {
                print("The dealer wins!")
                
                //Add the two cards in contest to the dealers hand
                computerHand.append(computersCard)
                computerHand.append(playersCard)
                
                //Show the info at the end of the turn
                showInfo(gameWinner: "Dealer", playersCards: playerHand.count, dealersCards: computerHand.count)

                
            }else if computersCard.value == playersCard.value // if the cards have the same value a war occurs
            {
                print("War")
                
                playerWarHand.append(playersCard)
                computerWarHand.append(computersCard)
                
                
                
                playWar()
                
//                //Pull two more cards from each contestant
//                var playersUnknownCard = playerHand[0]
//                playerHand.remove(at: 0)
//                
//                var playersKnownCard = playerHand[0]
//                playerHand.remove(at: 0)
//                
//                var computersUnknownCard = computerHand[0]
//                computerHand.remove(at: 0)
//                
//                var computersKnownCard = computerHand[0]
//                computerHand.remove(at: 0)
//                
//                //Prints out the known values for each contestants pulled cards
//                print("The dealer's card is a \(computersKnownCard.value + 1) of \(Suit.glyph(forHashValue: computersKnownCard.suit))")
//                
//                print("The player's card is a \(playersKnownCard.value + 1) of \(Suit.glyph(forHashValue: playersKnownCard.suit))")
//                
//                //Shows the cards for war
//                showCardsForWar(playerWarVisible: playersKnownCard, playerWarNotVisible: playersUnknownCard, dealerWarVisible: computersKnownCard, dealerWarNotVisible: computersUnknownCard, playerCard: playersCard, dealerCard: computersCard)
//                
//                //Deciding who wins the war
//                if playersKnownCard.value > computersKnownCard.value
//                {
//                    print("The player wins the war!")
//                   
//                    //Adding all of the cards to the players deck
//                    playerHand.append(computersCard)
//                    playerHand.append(playersCard)
//                    playerHand.append(computersUnknownCard)
//                    playerHand.append(playersUnknownCard)
//                    playerHand.append(computersKnownCard)
//                    playerHand.append(playersKnownCard)
//                    showInfo(gameWinner: "Player", playersCards: playerHand.count, dealersCards: computerHand.count)
//                }else if computersKnownCard.value > playersKnownCard.value
//                {
//                    print("The dealer wins the war!")
//                    
//                    //Adding all of the cards to hte dealers deck
//                    computerHand.append(computersCard)
//                    computerHand.append(playersCard)
//                    computerHand.append(computersUnknownCard)
//                    computerHand.append(playersUnknownCard)
//                    computerHand.append(computersKnownCard)
//                    computerHand.append(playersKnownCard)
//                    showInfo(gameWinner: "Dealer", playersCards: playerHand.count, dealersCards: computerHand.count)
//                }
                
            }
            
            sleep(1)
            
            if playerHand.count == 0 || computerHand.count == 0
            {
                gameIsOn = false
            }
        
    }
    
    
    
    
}
