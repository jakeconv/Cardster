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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func studyMarkedCardsPressed(_ sender: UIButton) {
        // Indicate that we're studying the flagged cards
        let parentVC = self.presentingViewController as! CardViewController
        parentVC.studyFlaggedCards()
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startOverPressed(_ sender: UIButton) {
        // Indicate that we're starting over
        let parentVC = self.presentingViewController as! CardViewController
        parentVC.reset()
        // Dismiss the popup
        self.dismiss(animated: true, completion: nil)
    }
}
