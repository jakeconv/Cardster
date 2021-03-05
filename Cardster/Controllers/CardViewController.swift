//
//  ViewController.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var flagButton: UIButton!
    
    var deckManager = DeckManager(cardFileName: "Whatever")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }

    @IBAction func flipButtonPressed(_ sender: Any) {
        deckManager.flip()
        updateViewFromModel()
    }
    
    @IBAction func flagButtonPressed(_ sender: Any) {
        deckManager.flag()
        updateViewFromModel()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        deckManager.nextCard()
        // Check and see if the deck has been completed
        if (deckManager.deckHasCompleted()) {
            // Run the popup
            self.performSegue(withIdentifier: "GoToFinishedVC", sender: self)
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        // Update the progress and label text
        print(deckManager.getProgress())
        progressBar.progress = deckManager.getProgress()
        let currentCard = deckManager.getCurrentCard()
        if (deckManager.currentCardIsFlipped) {
            cardLabel.text = currentCard.back
        }
        else {
            cardLabel.text = currentCard.front
        }
        if (currentCard.isFlagged) {
            flagButton.setTitle("Unflag", for: .normal)
        }
        else {
            flagButton.setTitle("Flag", for: .normal)
        }
    }
    
    func reset() {
        // Reset the current progress and start over
        print("WE RESETTIN")
        deckManager = DeckManager(cardFileName: "Whatever")
        progressBar.progress = 0.0
        updateViewFromModel()
    }
    
    func studyFlaggedCards() {
        // Study only the cards that were flagged
        print("WE FLAGGIN")
        let flaggedCards = deckManager.getFlaggedCards()
        deckManager = DeckManager(cards: flaggedCards)
        updateViewFromModel()
    }
    
    // Get the new view controller ready for the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Identifier is assigned in interface builder
        if segue.identifier == "GoToFinishedVC" {
            // This is called downcasting- we cast it down to Result View
            // the ! indicates that this is a forced downcast
            let destinationVC = segue.destination as! FinishedViewController
            let flaggedCards = deckManager.getFlaggedCards()
            if (flaggedCards.count > 0) {
                destinationVC.cardsAreFlagged = true
            } else {
                destinationVC.cardsAreFlagged = false
            }
            
        }
    }
    
}

