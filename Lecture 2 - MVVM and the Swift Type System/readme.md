## Lecture 2

[Video](https://www.youtube.com/watch?v=4GjXq2Sr55Q)

## Slides

<img src="https://github.com/dtroupe18/Stanford-CS193p-Developing-Apps-For-iOS/blob/master/Lecture%202%20-%20MVVM%20and%20the%20Swift%20Type%20System/Slides/MVVM.png" width="660" height="373">


<img src="https://github.com/dtroupe18/Stanford-CS193p-Developing-Apps-For-iOS/blob/master/Lecture%202%20-%20MVVM%20and%20the%20Swift%20Type%20System/Slides/Functions%20as%20Types.png" width="598" height="344">


<img src="https://github.com/dtroupe18/Stanford-CS193p-Developing-Apps-For-iOS/blob/master/Lecture%202%20-%20MVVM%20and%20the%20Swift%20Type%20System/Slides/struct%20vs%20class.png" width="580" height="321">


## Code

### ContentView

```swift
    import SwiftUI

    struct ContentView: View {
      // Instructor Note: Don't actually name this viewModel.
      var viewModel: EmojiMemoryGame

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
          .font(Font.largeTitle)
      }
    }


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
      }
    }

    struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
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

