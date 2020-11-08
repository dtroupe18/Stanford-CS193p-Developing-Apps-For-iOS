//
//  ContentView.swift
//  Memorize
//
//  Created by Dave Troupe on 5/20/20.
//  Copyright © 2020 DavidTroupe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  // Instructor Note: Don't actually name this viewModel.
  var viewModel: EmojiMemoryGame

  // When your game randomly shows 5 pairs, the font we are using for the
  // emoji will be too large (in portrait) and will start to get clipped.
  // Have the font adjust in the 5 pair case (only) to use a smaller font
  // than .largeTitle. Continue to use .largeTitle when there are 4 or
  // fewer pairs in the game.
  var font: Font {
    viewModel.cards.count == 10 ? Font.body : Font.largeTitle
  }

  var body: some View {
    return HStack {
      ForEach(viewModel.cards) { card in
        CardView(card: card).onTapGesture {
          self.viewModel.choose(card: card)
        }
      }
    }
      // These modifiers are applied to all views inside the HStack.
      .padding()
      .foregroundColor(Color.orange)
      .font(font)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: EmojiMemoryGame())
  }
}
