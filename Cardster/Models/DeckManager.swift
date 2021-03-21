//
//  Deck.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import Foundation

struct DeckManager {
    var cards: [Card]
    var indexOfCurrentCard = 0
    var currentCardIsFlipped = false
    
    // Initialize from the initial JSON file
    // TODO: Clean this up a bit
    init(cardFileName: String) {
        // First, check and see if we're working with a deck from the documents directory.
        let fm = FileManager.default
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = path.appendingPathComponent("\(cardFileName).json")
        print(fileURL.path)
        if (fm.fileExists(atPath: fileURL.path)) {
            // File exists.  We're good.
            print("This deck is from the documents directory.")
            let cardLoader = JSONCardLoader()
            cardLoader.loadCards(with: fileURL)
            if let loadedCards = cardLoader.cards {
                cards = loadedCards
                cards.shuffle()
            }
            else{
                cards = [Card(front: "An error occured", back: "Loading this deck")]
            }
        }
        else {
            print("\(cardFileName) is not from the documents directory.")
            // This deck is coming from the app bundle
            let filePath = Bundle.main.url(forResource: cardFileName, withExtension: "json")
            if let bundleFileURL = filePath {
                let cardLoader = JSONCardLoader()
                cardLoader.loadCards(with: bundleFileURL)
                if let loadedCards = cardLoader.cards {
                    cards = loadedCards
                    cards.shuffle()
                }
                else {
                    cards = [Card(front: "An error occured", back: "Loading this deck")]
                }
            }
            else {
                cards = [Card(front: "An error occured", back: "Loading this deck")]
            }
        }
    }
    
    // Initialize from a subset of preloaded cards
    init(cards: [Card]) {
        self.cards = cards
        self.cards.shuffle()
    }
    
    func getProgress() -> Float {
        // Return the progress of the current deck
        return Float(indexOfCurrentCard + 1)/Float(cards.count)
    }
    
    mutating func nextCard() {
        // Progress the deck to the next card
        indexOfCurrentCard += 1
        if (indexOfCurrentCard > cards.count - 1) {
            indexOfCurrentCard = 0
        }
        currentCardIsFlipped = false
    }
    
    mutating func lastCard() {
        // Go back to the previous card
        if (indexOfCurrentCard == 0) {
            // Nothing to go back to
            return
        } else {
            indexOfCurrentCard -= 1
            currentCardIsFlipped = false
        }
    }
    
    func count() -> Int {
        return cards.count
    }
    
    func currentCardNumber() -> Int {
        return indexOfCurrentCard + 1
    }
    
    mutating func flag() {
        // Flag the current card for follow-up
        if (cards[indexOfCurrentCard].isFlagged) {
            // Unflag the card
            cards[indexOfCurrentCard].isFlagged = false
        } else {
            // Flag the card
            cards[indexOfCurrentCard].isFlagged = true
        }
    }
    
    func getCurrentCard() -> Card {
        return cards[indexOfCurrentCard]
    }
    
    mutating func flip() {
        if currentCardIsFlipped {
            currentCardIsFlipped = false
        }
        else {
            currentCardIsFlipped = true
        }
        
    }
    
    // Check to see if the deck has repeated
    func deckHasCompleted() -> Bool {
        if indexOfCurrentCard == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    // Return a list of flagged cards to start over
    func getFlaggedCards() -> [Card] {
        var flaggedCards: [Card] = []
        for card in cards {
            if card.isFlagged {
                flaggedCards.append(card)
            }
        }
        return flaggedCards
    }
    
}
