//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dave Troupe on 5/20/20.
//  Copyright © 2020 DavidTroupe. All rights reserved.
//

import SwiftUI

// This is a class because lots of views will need access this model which
// means we want to use a class so they can share a pointer to this model.
final class EmojiMemoryGame {

  // Instructor Note: Don't actually name this model.
  private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

  static func createMemoryGame() -> MemoryGame<String> {
    // Edit -> Emoji's & Symbols.
    let emojis = ["👻", "🎃", "🕷"]

    return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
      return emojis[pairIndex]
    }
  }

  // MARK: Access to the Model

  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }

  // MARK: - Intent(s)

  func choose(card: MemoryGame<String>.Card) {
    model.choose(card: card)
  }
}
