//
//  WelcomeViewController.swift
//  Cardster
//
//  Created by Jake Convery on 3/6/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var decksTableView: UITableView!
    
    var cardFiles: [String] = []
    var selectedDeckFile = ""
    
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
        let deckLoader = DeckLoader()
        cardFiles = deckLoader.getAllDeckFilenames()
        // Set up the table view
        decksTableView.delegate = self
        decksTableView.dataSource = self
    }
    
}
    
// MARK: UITableViewDataSource
extension WelcomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Let the table count be the total number of card files
        return cardFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = cardFiles[indexPath.item]
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension WelcomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        print(cardFiles[indexPath.item])
        selectedDeckFile = "\(cardFiles[indexPath.item])_Set"
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
            destinationVC.fileName = selectedDeckFile
        }
        
    }
    
}


