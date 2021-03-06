//
//  FinishedViewController.swift
//  Cardster
//
//  Created by Jake Convery on 3/4/21.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var studyMarkedCardsButton: UIButton!
    
    var cardsAreFlagged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if (!cardsAreFlagged) {
            studyMarkedCardsButton.isHidden = true
        }
    }
    
    @IBAction func studyMarkedCardsPressed(_ sender: UIButton) {
        // Indicate that we're studying the flagged cards
        let container = self.presentingViewController as! UINavigationController
        let parentVC = container.viewControllers.last as! CardViewController
        parentVC.studyFlaggedCards()
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startOverPressed(_ sender: UIButton) {
        // Indicate that we're starting over
        let container = self.presentingViewController as! UINavigationController
        let parentVC = container.viewControllers.last as! CardViewController
        parentVC.reset()
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
}
