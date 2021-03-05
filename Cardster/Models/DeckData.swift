//
//  CardData.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import Foundation

struct DeckData: Decodable {
    let cards: [RawCard]
}

struct RawCard: Decodable {
    let front: String
    let back: String
}

