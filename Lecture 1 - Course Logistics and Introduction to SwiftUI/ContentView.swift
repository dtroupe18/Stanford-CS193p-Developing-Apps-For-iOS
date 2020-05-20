//
//  ContentView.swift
//  Memorize
//
//  Created by Dave Troupe on 5/20/20.
//  Copyright © 2020 DavidTroupe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    return HStack {
      ForEach(0..<4) { index in
        CardView(isFaceUp: false)
      }
    }
      .padding()
      .foregroundColor(Color.orange)
      .font(Font.largeTitle)
  }
}

struct CardView: View {
  var isFaceUp: Bool

  var body: some View {
    ZStack {
      if isFaceUp {
        RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
        Text("👻")
      } else {
        RoundedRectangle(cornerRadius: 10.0).fill()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
