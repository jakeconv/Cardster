//
//  WelcomeViewController.swift
//  Cardster
//
//  Created by Jake Convery on 3/6/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var decksTableView: UITableView!
    
    var cardFileDisplayNames: [String] = []
    var selectedDeckFile: CardFile?
    var deckLoader = DeckLoader()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This will hide the navigation bar
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // This will bring back the navigation bar when switching to a different view controller
        navigationController?.isNavigationBarHidden = false
    }
    
    // This will change the apperance of the status bar, since it is difficult to see black on the background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get a list of possible decks
        cardFileDisplayNames = deckLoader.getAllDeckDisplayNames()
        // Set up the table view
        decksTableView.delegate = self
        decksTableView.dataSource = self
    }
    
}
    
// MARK: UITableViewDataSource
extension WelcomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Let the table count be the total number of card files
        return cardFileDisplayNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = cardFileDisplayNames[indexPath.item]
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension WelcomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        print(cardFileDisplayNames[indexPath.item])
        selectedDeckFile = deckLoader.getCardFile(at: indexPath.item) // This index will allign with the deck files
        // Deselect the row
        decksTableView.deselectRow(at: indexPath, animated: false)
        // Go to the study screen
        self.performSegue(withIdentifier: "GoToCardVC", sender: self)
        
    }
    
    // Get ready to start the study session
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Identifier is assigned in interface builder
        if segue.identifier == "GoToCardVC" {
            // This is called downcasting- we cast it down to Result View
            // the ! indicates that this is a forced downcast
            let destinationVC = segue.destination as! CardViewController
            if let targetDeckFile = selectedDeckFile {
                destinationVC.cardFile = targetDeckFile
            }
        }
        
    }
    
}


