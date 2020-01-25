//
//  CreateQuestionView.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class CreateQuestionController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let create: UIButton = {
            let frame = CGRect(x: view.frame.width - 100, y: 20, width: 100, height: 50)
            let button = UIButton(type: .system)
            button.layer.cornerRadius = 10
            button.setTitle("Create", for: .normal)
            button.frame = frame
            button.addTarget(self, action: #selector(createQuestion), for: .touchUpInside)
            
            return button
        }()
        view.addSubview(create)
    }
    
    @objc func createQuestion() {
        let rvc = NewQuestionController()
        let vc = UINavigationController(rootViewController: rvc)
        //rvc.questionDelegate = self
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true, completion: nil)
    }
}


