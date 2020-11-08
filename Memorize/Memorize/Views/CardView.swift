//
//  CardView.swift
//  Memorize
//
//  Created by Dave Troupe on 11/8/20.
//  Copyright © 2020 David Troupe. All rights reserved.
//

import SwiftUI

/// Entire card view for the Memorize game.
struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            return body(for: geometry.size)
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        // Force each card to have a width to height ratio of 2:3
        // (this will result in empty space above and/or below your
        // cards, which is fine)
        .aspectRatio(2/3, contentMode: .fit)

        // Make the font size related to the size of the view.
        .font(Font.system(size: fontSize(for: size)))
    }

    // MARK: - Drawing Constants

    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}
