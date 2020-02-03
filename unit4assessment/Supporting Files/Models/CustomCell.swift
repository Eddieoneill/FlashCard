//
//  CustomCell.swift
//  unit4assessment
//
//  Created by Edward O'Neill on 1/24/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var facts = [String]()
    var titleName = String()
    var isTitle = true
    var indexPath: IndexPath?
    
    var addButton: ModdedUIButton = {
        let button = ModdedUIButton()
        button.layer.cornerRadius = 10
        return button
    }()
    
    var titleLabel: UILabel = {
        let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton.cell = self
        contentView.addSubview(titleLabel)
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModdedUIButton: UIButton {
    var cell: CustomCell?
}
