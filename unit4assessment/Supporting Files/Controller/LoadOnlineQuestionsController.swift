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
    var collections = [UICollectionViewCell]()
    
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
        loadQuestion()
        view.addSubview(createButton())
        view.backgroundColor = .gray
    }
    
    func createButton() -> UIButton {
        let frame = CGRect(x: view.frame.width - 105, y: 20, width: 100, height: 20)
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.frame = frame
        button.setTitle("Load Cells", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addQuestions), for: .touchUpInside)
        
        return button
    }
    
    @objc func addQuestions() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1).isActive = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
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

extension LoadOnlineQuestionsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = view.frame.width
        let size = CGSize(width: (viewWidth / 2 - 5), height: (viewWidth - 60))
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cards[0].cards)
        return cards[0].cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let label = UILabel()
        
        label.frame = CGRect(x: 20, y: 20, width: cell.frame.width, height: cell.frame.height)
        label.text = cards[0].cards[indexPath.row].cardTitle
        cell.contentView.addSubview(label)
        cell.backgroundColor = .white
        collections.append(cell)
        return cell
    }
}

//    extension ViewController: UITableViewDataSource, UITableViewDelegate {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return elementList.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//            let element = elementList[indexPath.row]
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementX") as? ElementTableViewCell else {return UITableViewCell()}
//            cell.setElement(element: element)
//            return cell
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return CGFloat(200)
//        }
//
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            switch segue.identifier! {
//            case "ElementDetailScreen":
//                if let destination = segue.destination as? ElementDetailViewController {
//                    destination.element = elementList[tableView.indexPathForSelectedRow!.row]
//                }
//            default:
//                fatalError()
//            }
//
//        }
//}
