//
//  ViewController.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    var deckManager: DeckManager?
    var cardFile: CardFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Back"
        // Do any additional setup after loading the view.
        deckManager = DeckManager(cardFile: cardFile!)
        updateViewFromModel()
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        // Go back to the last card
        deckManager?.lastCard()
        updateViewFromModel()
    }
    
    @IBAction func flagButtonPressed(_ sender: Any) {
        // Flag the current card for review
        deckManager?.flag()
        updateViewFromModel()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        // Go to the next card
        deckManager?.nextCard()
        // Check and see if the deck has been completed
        if (deckManager!.deckHasCompleted()) {
            // Run the popup
            self.performSegue(withIdentifier: "GoToFinishedVC", sender: self)
        }
        updateViewFromModel()
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        // User tapped on the index card.  Flip the card.
        deckManager?.flip()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        // Update the progress and label text
        progressBar.progress = deckManager?.getProgress() ?? 0.0
        let currentCard = deckManager?.getCurrentCard()
        progressLabel.text = "Card \(deckManager!.currentCardNumber()) of \(deckManager!.count())"
        if (deckManager!.currentCardIsFlipped) {
            UIView.performWithoutAnimation {
                cardButton.setTitle(currentCard?.back, for: .normal)
                cardButton.layoutIfNeeded()
            }
        }
        else {
            UIView.performWithoutAnimation {
                cardButton.setTitle(currentCard?.front, for: .normal)
                cardButton.layoutIfNeeded()
            }
        }
        if (currentCard!.isFlagged) {
            flagButton.setTitle("Unflag", for: .normal)
        }
        else {
            flagButton.setTitle("Flag", for: .normal)
        }
    }
    
    func reset() {
        // Reset the current progress and start over
        deckManager = DeckManager(cardFile: cardFile!)
        progressBar.progress = 0.0
        updateViewFromModel()
    }
    
    func studyFlaggedCards() {
        // Study only the cards that were flagged
        let flaggedCards = deckManager?.getFlaggedCards()
        deckManager = DeckManager(cards: flaggedCards!)
        updateViewFromModel()
    }
    
    // Get the new view controller ready for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Identifier is assigned in interface builder
        if segue.identifier == "GoToFinishedVC" {
            // This is called downcasting- we cast it down to Result View
            // the ! indicates that this is a forced downcast
            let destinationVC = segue.destination as! FinishedViewController
            let flaggedCards = deckManager!.getFlaggedCards()
            if (flaggedCards.count > 0) {
                destinationVC.cardsAreFlagged = true
            } else {
                destinationVC.cardsAreFlagged = false
            }
            
        }
    }
    
}

