//
//  main.swift
//  War
//
//  Created by Student on 2016-12-07.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

print("War!")

struct person
{
    var name = ""
    var numberOfCards = 0
}

struct deckOfCards
{
    var numberOfCards = 52
    var deck = [card]()
    
    mutating func setupDeck()
    {
        for i in 1...13
        {
            for j in 1...4
            {
                deck.append(card(face: j, number: i))
            }
        }
    }
    
    var shuffledDeck = [card](count: 52)
    
    mutating func shuffle()
    {
        for index in 0...51
        {
            
        }
    }
    
}

struct card
{
    var face = 0
    var number = 0
}
