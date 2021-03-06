//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dave Troupe on 5/20/20.
//  Copyright © 2020 DavidTroupe. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>

    func index(of card: Card) -> Int? {
        return cards.firstIndex(where: { $0.id == card.id })
    }

    mutating func choose(card: Card) {
        print("card chosen: \(card)")

        // Card is a let (all variables in functions are). Additionally,
        // Card is a value type so we are working on a copy. Thus the below code
        // does not work.
        // -> Does NOT work: card.isFaceUp.toggle()

        if let choosenIndex = index(of: card) {
            cards[choosenIndex].isFaceUp.toggle()
        }
    }
    
    /// Initializer
    ///
    /// - parameter numberOfPairsOfCards: Int.
    /// - parameter cardContentfactory: function that takes an Int and returns CardContent.
    init(numberOfPairsOfCards: Int, cardContentfactory: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentfactory(pairIndex)

            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }

        // Assignment 1
        // Currently the cards appear in a predictable order
        // (the matches are always side-by-side, making the game very easy).
        // Shuffle the cards.
        cards.shuffle() // Shuffles the collection in place.
    }

    // Nesting structs is mainly a name spacing thing. This is really
    // MemoryGame.Card so we know this isn't another type of Card.
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false

        // Generic, type is declared when MemoryGame is instantiated.
        // Ex: MemoryGame<String>
        var content: CardContent
        var id: Int
    }
}
