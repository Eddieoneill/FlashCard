//
//  YourQuestionsView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class YourQuestionsController: UIViewController {
    
    var savedQuestions = [CustomCell]()
    var storedCells = [CustomCell]()
    var count = 0
    
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
        view.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbar = tabBarController as! BaseTabBarController
        savedQuestions = Array(tabbar.sharedCells)
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1).isActive = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabbar = tabBarController as! BaseTabBarController
        savedQuestions = Array(tabbar.sharedCells)
        collectionView.reloadData()
    }
    
    @IBAction func gesture(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            if storedCells[indexPath.row].isTitle {
                storedCells[indexPath.row].isTitle = false
                UIView.transition(with: storedCells[indexPath.row], duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                storedCells[indexPath.row].titleLabel.text = storedCells[indexPath.row].facts.randomElement()!
                storedCells[indexPath.row].addButton.isEnabled = false
                storedCells[indexPath.row].addButton.alpha = 0
            } else {
                storedCells[indexPath.row].isTitle = true
                UIView.transition(with: storedCells[indexPath.row], duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                storedCells[indexPath.row].titleLabel.text = storedCells[indexPath.row].titleName
                storedCells[indexPath.row].addButton.isEnabled = true
                storedCells[indexPath.row].addButton.alpha = 1
            }
        }
    }
    
    func setupView() -> UIGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(gesture(_:)))
    }
    
    func createButton(_ cell: UICollectionViewCell) -> UIButton {
        let frame = CGRect(x: cell.frame.width - 24, y: 4, width: 20, height: 20)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.frame = frame
        button.setBackgroundImage(UIImage(named: "more-filled"), for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(removeCell), for: .touchUpInside)
        button.tag = cell.tag
        
        return button
    }
    
    func checkData() -> UIButton {
        let frame = CGRect(x: 10, y: 15, width: 100, height: 20)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.frame = frame
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(gotTheData), for: .touchUpInside)
        
        return button
    }
    
    @objc func removeCell(_ sender: ModdedUIButton) {
        let cell = sender.cell
        
        
    }
    
    @objc func gotTheData() {
        print(savedQuestions.count)
    }
}

extension YourQuestionsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let size = CGSize(width: (viewWidth / 2 - 5), height: (viewWidth - 60))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.titleLabel.text = savedQuestions[indexPath.row].titleName
        cell.facts = savedQuestions[indexPath.row].facts
        cell.titleName = savedQuestions[indexPath.row].titleName
        cell.titleLabel.numberOfLines = 0
        cell.addButton.frame = CGRect(x: cell.frame.width - 55, y: 5, width: 50, height: 50)
        cell.addButton.setImage(UIImage(named: "more-filled"), for: .normal)
        cell.addButton.addTarget(self, action: #selector(removeCell(_:)), for: .touchUpInside)
        cell.indexPath = indexPath
        cell.tag = count
        cell.backgroundColor = .white
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(setupView())
        storedCells.append(cell)
        count += 1
        return cell
    }
}


extension YourQuestionsController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point = touch.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point),
            let cell = collectionView.cellForItem(at: indexPath) {
            return touch.location(in: cell).y > 50
        }
        return false
    }
}
