//
//  Cards.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/27/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let cardTitle: String
    let facts: [String]
}
