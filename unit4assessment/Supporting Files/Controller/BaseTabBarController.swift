//
//  BaseTabBarController.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/28/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var sharedCells: [CustomCell] = []
    var cards: [Cards] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()
    }
    
    func loadQuestion() {
        CardsAPI.getQuestion { (result) in
            switch result {
            case .failure(let appError):
                fatalError("couldn't load questions: \(appError)")
            case .success(let card):
                self.cards.append(card)
            }
        }
    }
}
