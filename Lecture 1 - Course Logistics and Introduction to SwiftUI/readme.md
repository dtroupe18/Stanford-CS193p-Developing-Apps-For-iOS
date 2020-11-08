## Lecture 1

### Code

```swift
    import SwiftUI

    struct ContentView: View {
      var body: some View {
        return HStack {
          ForEach(0..<4) { index in
            CardView(isFaceUp: false)
          }
        }
          // These modifiers are applied to all views inside the HStack.
          .padding()
          .foregroundColor(Color.orange)
          .font(Font.largeTitle)
      }
    }

    /**
     Entire card view for the Memorize game.
     */
    struct CardView: View {
      var isFaceUp: Bool

      var body: some View {
        ZStack {
          if isFaceUp {
            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
            Text("👻") // Edit -> Emoji's & Symbols.
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
```

