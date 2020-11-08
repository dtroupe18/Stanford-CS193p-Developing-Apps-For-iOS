## Lecture 3 - Reactive UI + Protocols + Layout

## Lecture 2

[Video](https://www.youtube.com/watch?v=4GjXq2Sr55Q)

[Slides](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/l3_0.pdf)


## Code

### ContentView

```swift
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
```

### CardView

```swift
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
```


### EmojiMemoryGame

```swift
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
```


### MemoryGame

```swift
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
```


### SceneDelegate

```swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
      // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
      // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

      // Create the SwiftUI view that provides the window contents.
      let game = EmojiMemoryGame()
      let contentView = ContentView(viewModel: game)

      // Use a UIHostingController as window root view controller.
      if let windowScene = scene as? UIWindowScene {
          let window = UIWindow(windowScene: windowScene)
          window.rootViewController = UIHostingController(rootView: contentView)
          self.window = window
          window.makeKeyAndVisible()
      }
    }
```


