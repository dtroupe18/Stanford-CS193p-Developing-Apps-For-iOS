//
//  CardView.swift
//  Memorize
//
//  Created by Dave Troupe on 11/8/20.
//  Copyright © 2020 DavidTroupe. All rights reserved.
//

import SwiftUI

/// Entire card view for the Memorize game.
struct CardView: View {
  var card: MemoryGame<String>.Card

  var body: some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
        Text(card.content)
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()
      }
    }
      // Force each card to have a width to height ratio of 2:3
      // (this will result in empty space above and/or below your
      // cards, which is fine)
      .aspectRatio(0.66, contentMode: .fit)
  }
}
