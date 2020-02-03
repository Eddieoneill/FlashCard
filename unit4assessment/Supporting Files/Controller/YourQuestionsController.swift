//
//  YourQuestionsView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import CoreData

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
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1).isActive = true
        collectionView.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        let tabbar = tabBarController as! BaseTabBarController
        savedQuestions = tabbar.sharedCells
        collectionView.reloadData()

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
        count = 0
        let cell = sender.cell
        let tabbar = tabBarController as! BaseTabBarController
        tabbar.sharedCells.remove(at: cell!.tag)
        savedQuestions.remove(at: cell!.tag)
        collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCell else { return }
            if selectedCell.isTitle {
            selectedCell.isTitle = false
            UIView.transition(with: selectedCell, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            selectedCell.titleLabel.text = selectedCell.facts.randomElement()!
            selectedCell.addButton.isEnabled = false
            selectedCell.addButton.alpha = 0
        } else {
            selectedCell.isTitle = true
            UIView.transition(with: selectedCell, duration: 1, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            selectedCell.titleLabel.text = selectedCell.titleName
            selectedCell.addButton.isEnabled = true
            selectedCell.addButton.alpha = 1
        }
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
        cell.tag = count
        cell.indexPath = indexPath
        cell.backgroundColor = .white
        storedCells.append(cell)
        count += 1
        return cell
    }
}
