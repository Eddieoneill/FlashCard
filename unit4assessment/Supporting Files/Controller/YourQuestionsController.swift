//
//  YourQuestionsView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class YourQuestionsController: UIViewController {
    
    var collection = [UICollectionViewCell]()
    var labels = [UILabel]()
    var cellCount = 1
    var questionList = [[String: [String]]]()
    var isOpen = false
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
    
    fileprivate func setupView(_ cell: UICollectionViewCell) -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(moveCell))
        return tap
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1).isActive = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if count == 0 {
            count += 1
        } else {
            let rvc = NewQuestionController()
            rvc.questionDelegate = self
        }
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
    
    @objc func moveCell() {
        if isOpen {
            isOpen = false
            UIView.transition(with: collection[0], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            labels[0].text = "hello"
        } else {
            isOpen = true
            UIView.transition(with: collection[0], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            labels[0].text = "I'm back"
        }
    }
    
    @objc func removeCell(_ cell: UICollectionViewCell) {
        cell.removeFromSuperview()
    }
    
    
}

extension YourQuestionsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let size = CGSize(width: (viewWidth / 2 - 5), height: (viewWidth - 60))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel()
        //        for label in labels {
        //            label.removeFromSuperview()
        //        }
        cell.addSubview(label)
        label.tag = cellCount
        label.frame = CGRect(x: 20, y: 20, width: cell.frame.width, height: cell.frame.height)
        label.text = "\(cellCount)"
        label.textColor = .black
        labels.append(label)
        collection.append(cell)
        cell.addSubview(createButton(cell))
        cell.tag = cellCount
        cell.backgroundColor = .white
        cellCount += 1
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(setupView(cell))
        print(labels.count)
        return cell
    }
}

extension YourQuestionsController: NewQuestionDelegate {
    func didAddQuestion(_ question: String) {
        let label = UILabel(frame: CGRect(x: 0, y: collection[0].bounds.size.height / 2, width: 100, height: 100))
        label.text = question
        collection[0].contentView.addSubview(label)
    }
}
