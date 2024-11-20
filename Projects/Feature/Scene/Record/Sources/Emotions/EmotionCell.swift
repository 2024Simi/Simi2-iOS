//
//  EmotionCell.swift
//  Record
//
//  Created by 박서연 on 2024/11/20.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Models

class EmotionCell: UICollectionViewCell {
    static let identifier = "EmotionCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .coolgray900
        label.font = FontCase.semibold(.subheadline).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.clear, for: .normal)
        button.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.coolgray200.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String, emotionType: EmotionType) {
//        button.setTitle(text, for: .normal)
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.coolgray500, for: .normal)
        button.backgroundColor = emotionType.color
    }
}
