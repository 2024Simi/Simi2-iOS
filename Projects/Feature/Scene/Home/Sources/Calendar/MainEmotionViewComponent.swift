//
//  MainEmotionViewComponent.swift
//  Home
//
//  Created by 박서연 on 2024/12/07.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class MainEmotionViewComponent: UIView {
    public var buttonTapped: (() -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.backgroundColor = .coolgray800
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 8
        self.backgroundColor = .coolgray800
        setupConstraints()
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "오늘의 주 감정은"
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .coolgray400
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainEmotionLabel: UILabel = {
        let label = UILabel()
        label.text = "행복함"
        label.applyFontCase(.semibold(.title3))
        label.textColor = .coolgray50
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emotionButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .coolgray200
        config.image = .icChevronRight
        config.baseForegroundColor = .gray900
        config.imagePlacement = .trailing
        config.imagePadding = 4
        config.cornerStyle = .capsule // 버튼 모양

        // 폰트 설정
        var title = AttributedString("감정 기록하기")
        title.font = FontCase.bold(.caption1).toUIFont
        config.attributedTitle = title
        
        // 이미지 크기 설정
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        config.preferredSymbolConfigurationForImage = imageConfig

        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()

    
    private let emotionView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.layer.bounds.width / 2
        view.clipsToBounds = true
        return view
    }()
    
    private let containStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let emotionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .icHappy
        return image
    }()
}

extension MainEmotionViewComponent {
    @objc func tappedButton() {
        buttonTapped?()
    }
}

public extension MainEmotionViewComponent {
    func setupConstraints() {
        addSubview(emotionView)
        addSubview(label)
        addSubview(mainEmotionLabel)
        addSubview(emotionButton)
        addSubview(emotionImage)
        
        emotionView.layer.cornerRadius = emotionView.layer.bounds.width / 2
        emotionView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            emotionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            emotionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emotionView.widthAnchor.constraint(equalToConstant: 6),
            emotionView.heightAnchor.constraint(equalToConstant: 6),
            label.topAnchor.constraint(equalTo: emotionView.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainEmotionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            mainEmotionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emotionButton.topAnchor.constraint(equalTo: mainEmotionLabel.bottomAnchor, constant: 12),
            emotionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            emotionButton.heightAnchor.constraint(equalToConstant: 28),
            emotionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            emotionImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emotionImage.widthAnchor.constraint(equalToConstant: 63),
            emotionImage.heightAnchor.constraint(equalToConstant: 63)
        ])
    }
}
