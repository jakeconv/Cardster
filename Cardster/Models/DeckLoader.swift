//
//  DeckLoader.swift
//  Cardster
//
//  Created by Jake Convery on 3/21/21.
//

import Foundation

struct DeckLoader {
    
    // File manager for all reads
    let fm = FileManager.default
    
    // All deck files
    var deckFiles: [CardFile] = []
    
    init() {
        // Get the card filenames upon initializing this struct
        readCardFilesFromBundle()
        readCardFilesFromDocuments()
        // Sort the decks alphabetically
        sort()
    }
    
    mutating func readCardFilesFromBundle() {
        // Thanks to https://www.hackingwithswift.com/read/1/2/listing-images-with-filemanager
        let path = Bundle.main.resourcePath!
        let files = try! fm.contentsOfDirectory(atPath: path)
        checkForDecks(files, location: .bundle)
    }
    
    mutating func readCardFilesFromDocuments() {
        // Thanks to https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory
        if (checkForDocumentsDirectory()) {
            // The documents directory is visible from the files app.  Look for card decks.
            let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
            do {
                let files = try fm.contentsOfDirectory(atPath: path.path)
                checkForDecks(files, location: .documents)
            
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    mutating func checkForDecks(_ files: [String], location: CardFileLocation) {
        for item in files {
            // Look for files that look like decks
            if item.hasSuffix(".card") {
                // This is a card deck.
                deckFiles.append(CardFile(fileName: item, location: location))
            }
        }
    }
    
    mutating func sort() {
        // Sort the files alphabetically
        deckFiles = deckFiles.sorted(by: {$0.displayName < $1.displayName})
    }
    
    func checkForDocumentsDirectory() -> Bool {
        let path = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        // See if a readme file exists.  This is needed for the Cardster folder to appear in the files app.
        let fileURL = path.appendingPathComponent("readme.txt")
        print(fileURL)
        if (fm.fileExists(atPath: fileURL.path)) {
            // File exists.  We're good.
            print("Readme file exists.")
            return true
        }
        else {
            // Readme file does not exist.  Create it now.
            let readmeText = "Drop any custom decks into this directoy for them to appear in the Cardster app.  Be sure to se the extension \".card\"."
            do {
                try readmeText.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print(error.localizedDescription)
            }
            return false
        }
    }
    
    func getAllDeckDisplayNames() -> [String] {
        // Return a list of all available deck files.
        var filenames: [String] = []
        for file in deckFiles {
            filenames.append(file.displayName)
        }
        return filenames
    }
    
    func getCardFile(at index: Int) -> CardFile {
        // Return a specified card file
        return deckFiles[index]
    }
    
}
