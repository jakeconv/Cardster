//
//  CardFile.swift
//  Cardster
//
//  Created by Jake Convery on 3/24/21.
//

import Foundation

struct CardFile {
    var fileName: String
    var displayName: String {
        return String(fileName.dropLast(5))
    }
    var location: CardFileLocation
}

enum CardFileLocation {
    case bundle, documents
}
