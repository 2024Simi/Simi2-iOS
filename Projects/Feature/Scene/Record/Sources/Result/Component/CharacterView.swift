//
//  CharacterView.swift
//  Home
//
//  Created by 박서연 on 2024/11/27.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Models

public class CharacterResultView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private let characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let mainEmotionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyFontCase(FontCase.bold(.caption1))
        label.textColor = .coolgray800
        return label
    }()
    
    private let empathyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.applyFontCase(FontCase.semibold(.subheadline))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .coolgray900
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupView() {
        stackView.addArrangedSubview(mainEmotionLabel)
        stackView.addArrangedSubview(empathyLabel)
        containerView.layer.cornerRadius = 4
        containerView.addSubview(stackView)
        totalView.addSubview(characterImageView)
        totalView.addSubview(containerView)
        addSubview(totalView)
        
        NSLayoutConstraint.activate([
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 131),
            characterImageView.heightAnchor.constraint(equalToConstant: 131),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            
            containerView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: totalView.bottomAnchor, constant: -16),
            
            totalView.topAnchor.constraint(equalTo: topAnchor),
            totalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: trailingAnchor),
            totalView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func configure(mainEmotion: String, empathyMessage: String, stackViewColor: UIColor, image: UIImage) {
        mainEmotionLabel.text = "오늘의 주 감정은, \(mainEmotion)"
        empathyLabel.text = empathyMessage
        containerView.backgroundColor = stackViewColor
        characterImageView.image = image
    }
}
