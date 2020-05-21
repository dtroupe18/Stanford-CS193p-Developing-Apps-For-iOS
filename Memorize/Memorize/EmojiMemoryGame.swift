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
    var emojis = ["👻", "🎃", "🙀", "💀", "😱", "☠️", "🦇", "😈", "🍭", "🕷", "🕸", "🧡"]

    // Have your game start up with a random number of pairs of cards between 2 pairs and 5 pairs.
    return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in
      // EXTRA CREDIT:
      // Have the emoji on your cards be randomly chosen from a larger set of emoji
      // (at least a dozen). In other words, don’t always use the same five emoji in every game.
      let randomEmoji = emojis.randomElement()! // This is only nil if the collection is empty.
      let index = emojis.firstIndex(of: randomEmoji)! // This can't be nil since we look it from the collection.
      emojis.remove(at: index) // Prevent the same emoji from getting selected again.

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
