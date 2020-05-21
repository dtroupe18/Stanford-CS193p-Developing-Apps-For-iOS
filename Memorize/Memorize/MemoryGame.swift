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

  func choose(card: Card) {
    print("card chosen: \(card)")
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
  }

  // Nesting structs is mainly a name spacing thing. This is really
  // MemoryGame.Card so we know this isn't another type of Card.
  struct Card: Identifiable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false

    // Generic, type is declared when MemoryGame is instantiated.
    // Ex: MemoryGame<String>
    var content: CardContent
    var id: Int
  }
}
