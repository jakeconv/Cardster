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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Get a list of possible decks
        getCardFiles()
        // Set up the table view
        decksTableView.delegate = self
        decksTableView.dataSource = self
    }
    
    func getCardFiles(){
        // Thanks to https://www.hackingwithswift.com/read/1/2/listing-images-with-filemanager
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        var fileNames: [String] = []
        for item in items {
            if item.hasSuffix("_Set.json") {
                // This is a card deck.
                fileNames.append(String(item.dropLast(9)))
            }
        }
        // Sort alphabetically
        cardFiles = fileNames.sorted {$0 < $1}
        print(cardFiles)
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
        selectedDeckFile = "\(cardFiles[indexPath.item])_Set"
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


