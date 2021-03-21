#  Cardster
## A simple flashcard app

This is just a very basic, no frills flashcard app that I wrote to kill two birds with one stone: learn more about iOS programming in Swift 5 while simultaneously studying the Spanish language. Other, better solutions might exist to review flashcards on the go, but this implementation is beneficial because no subscription fees are required to access flashcard decks offline, which proves quite useful when taking the train to work each morning and afternoon (bridge and tunnel crew represent!).  Hope you enjoy! 😃

## Running the app

This app was designed for iOS 14.4 using Swift 5 in Xcode 12.4.  To get started, clone this repository into a directory of your choosing.  Locate the Cardster.xcodeproj file, open it, and then select the target of your choosing- wether it be an iPhone or iPad in the simulator, a real iOS device, or a Mac, and hit the play button.

## Using the app

Upon launch, the app will display all of the card decks that are available.  Tapping on any deck name will launch the study screen.  In the study screen, tap on the index card to reveal the back of the card.  Tap again to return to the front.  Hitting the Flag button will mark the card for follow up.  The next and back buttons allow for navigation through the deck.  At any time, hit the back arrow on the top left side of the screen to choose a different deck.

## Adding new cards

As it currently stands, cards are loaded in from a JSON file containing an array of cards, and some example sets are included in the Cards directory.  Card file names must end in "_Set.json".  If they do not have this ending, then the app won't find them.  Within each file, there is an array of items, and each item must contain a string value for "front" and "back".  Once again, see one of the example sets to get an idea of how should look.  Upon the first run of the app, a documents directory will be created and you can add in these deck files from the Files app in iOS.  Or, deck files can be added into the Cards directory visible within Xcode.  For a simple macOS app to help build decks, please see one of my other projects, [Cardster Editor](https://github.com/jakeconv/CardsterEditor).
