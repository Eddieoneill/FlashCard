//
//  LoadOnlineQuestionsView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class LoadOnlineQuestionsController: UIViewController {
    
    var cards = [Cards]()
    var collections = [CustomCell]()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = tabBarController as! BaseTabBarController
        cards = tabbar.cards
        view.backgroundColor = .gray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        self.view.addSubview(self.collectionView)
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 1).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1).isActive = true
        self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 1).isActive = true
        self.collectionView.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! BaseTabBarController
        cards = tabbar.cards
        collectionView.reloadData()
    }
    
    @IBAction func gesture(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            if collections[indexPath.row].isTitle {
                collections[indexPath.row].isTitle = false
                UIView.transition(with: collections[indexPath.row], duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                collections[indexPath.row].titleLabel.text = collections[indexPath.row].facts.randomElement()!
                collections[indexPath.row].addButton.isEnabled = false
                collections[indexPath.row].addButton.alpha = 0
            } else {
                collections[indexPath.row].isTitle = true
                UIView.transition(with: collections[indexPath.row], duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                collections[indexPath.row].titleLabel.text = collections[indexPath.row].titleName
                collections[indexPath.row].addButton.isEnabled = true
                collections[indexPath.row].addButton.alpha = 1
            }
        }
    }
    
    @IBAction func addCell(_ sender: ModdedUIButton) {
        let cell = sender.cell
        let tabbar = tabBarController as! BaseTabBarController
        
        tabbar.sharedCells.insert(cell!)
    }
    
    func setupView() -> UIGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(gesture(_:)))
    }
}

extension LoadOnlineQuestionsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let size = CGSize(width: (viewWidth - 20), height: (viewWidth - 60))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards[0].cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.titleName = cards[0].cards[indexPath.row].cardTitle
        cell.titleLabel.text = cell.titleName
        cell.facts = cards[0].cards[indexPath.row].facts
        cell.titleLabel.numberOfLines = 0
        cell.addButton.frame = CGRect(x: cell.frame.width - 55, y: 5, width: 50, height: 50)
        cell.addButton.setImage(.add, for: .normal)
        cell.addButton.addTarget(self, action: #selector(addCell(_:)), for: .touchUpInside)
        cell.addButton.cell = cell
        cell.backgroundColor = .white
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(setupView())
        collections.append(cell)
        
        return cell
    }
}

extension LoadOnlineQuestionsController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point = touch.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point),
            let cell = collectionView.cellForItem(at: indexPath) {
            return touch.location(in: cell).y > 50
        }
        return false
    }
}

