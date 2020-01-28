//
//  YourQuestionsView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

protocol PassCellDelegate {
    func save(cell: CustomCell)
}

class YourQuestionsController: UIViewController {
    
    var savedQuestions = [CustomCell]()
    
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
        view.addSubview(collectionView)
        view.addSubview(checkData())
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1).isActive = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = LoadOnlineQuestionsController()
        vc.saveDelegate = self
        //present(vc, animated: true, completion: nil)
        
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
        let frame = CGRect(x: 10, y: 10, width: 20, height: 100)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.frame = frame
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(gotTheData), for: .touchUpInside)
        
        return button
    }
    
    @objc func removeCell(_ cell: UICollectionViewCell) {
        cell.removeFromSuperview()
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .white
        return cell
    }
}

extension YourQuestionsController: PassCellDelegate {
    func save(cell: CustomCell) {
        self.savedQuestions.append(cell)
    }
}
