//
//  JSONCardLoader.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import Foundation

class JSONCardLoader {
    
    var cards: [Card]?
    
    func loadCards(with url: URL) {
        let session = URLSession(configuration: .default)
        let sem = DispatchSemaphore.init(value: 0)
        let task = session.dataTask(with: url) { (data, response, error) in
            defer { sem.signal() }
            if (error != nil) {
                print(error!)
                return
            }
            if let safeData = data {
                if let deckData = self.parseJSON(safeData) {
                    var cards: [Card] = []
                    for card in deckData.cards {
                        let newCard = Card(front: card.front, back: card.back)
                        print(newCard.front)
                        cards.append(newCard)
                    }
                    self.cards = cards
                    print(self.cards)
                }
                else {
                    return
                }
            }
        }
        task.resume()
        sem.wait()
    }
    
    func parseJSON(_ deckData: Data) -> DeckData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DeckData.self, from: deckData)
            return decodedData
        }
        catch {
            print(error)
            return nil
        }
    }
    
    
    
}
