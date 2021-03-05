//
//  Card.swift
//  Cardster
//
//  Created by Jake Convery on 2/21/21.
//

import Foundation

struct Card: Decodable {
    let front: String
    let back: String
    var isFlagged = false
    
}
