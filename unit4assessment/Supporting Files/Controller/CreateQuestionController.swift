//
//  CreateQuestionView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class CreateQuestionController: UIViewController {
    
    var addButton = UIButton()
    var questionTitle = UITextField()
    var questionfact1 = UITextField()
    var questionfact2 = UITextField()
    let numbersToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add: UIButton = {
            let frame = CGRect(x: view.frame.width / 2 - 50, y: view.frame.height - 100, width: 100, height: 50)
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.layer.cornerRadius = 10
            button.setTitle("Add", for: .normal)
            button.frame = frame
            button.addTarget(self, action: #selector(addNewQuestion), for: .touchUpInside)
            return button
        }()
        
        let titleField = UITextField(frame: CGRect(x: 10, y: 75, width: view.frame.width - 20, height: view.frame.width / 2))
        let fact1 = UITextField(frame: CGRect(x: 10, y: view.frame.width / 2 + 85, width: view.frame.width - 20, height: view.frame.width / 2 - 50))
        let fact2 = UITextField(frame: CGRect(x: 10, y: view.frame.width + 40, width: view.frame.width - 20, height: view.frame.width / 2 - 50))
        numbersToolbar.barStyle = .default
        numbersToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        numbersToolbar.sizeToFit()
        titleField.backgroundColor = .lightGray
        titleField.alpha = 0.5
        titleField.placeholder = "Please enter the title"
        titleField.inputAccessoryView = numbersToolbar
        fact1.backgroundColor = .lightGray
        fact1.alpha = 0.5
        fact1.placeholder = "Please enter the first fact"
        fact1.inputAccessoryView = numbersToolbar
        fact2.backgroundColor = .lightGray
        fact2.alpha = 0.5
        fact2.placeholder = "Please enter the second fact"
        fact2.inputAccessoryView = numbersToolbar
        addButton = add
        questionTitle = titleField
        questionfact1 = fact1
        questionfact2 = fact2
        view.addSubview(questionfact1)
        view.addSubview(questionfact2)
        view.addSubview(addButton)
        view.addSubview(questionTitle)
        view.backgroundColor = .white
    }
    
    @objc func addNewQuestion() {
        let newCell = CustomCell()
        let tabbar = tabBarController as! BaseTabBarController
        newCell.titleName = questionTitle.text ?? "no title"
        newCell.facts = [questionfact1.text ?? "no fact 1", questionfact2.text ?? "no fact 2"]
        tabbar.sharedCells.insert(newCell)
        
        questionTitle.text = ""
        questionfact1.text = ""
        questionfact2.text = ""
    }
    
    @objc func doneWithNumberPad() {
        self.view.endEditing(true)
    }
}


