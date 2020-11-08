//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dave Troupe on 5/20/20.
//  Copyright © 2020 David Troupe. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Instructor Note: Don't actually name this viewModel.
    // @ObservedObject just means the viewModel is an observableObject and this is used to redraw the view.
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        return HStack {
            ForEach(viewModel.cards) { card in
                // Note: SwiftUI is smart and only redraws the view(s) that have changed. This is
                // why a Card must be Identifiable.
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        // These modifiers are applied to all views inside the HStack.
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
