//
//  PastNoneRecordComponentView.swift
//  Home
//
//  Created by 박서연 on 2024/12/10.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class PastNoneRecordComponentView: UIView {

    public var buttonTapped: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        
        layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        setupConstraints()
        
        layer.cornerRadius = 4
    }
    
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray400
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    private let lastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .coolgray400
        label.text = "지난날의 감정기록"
        return label
    }()
    
    private let aboutDiaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "작성된 일기가 없어요"
        label.applyFontCase(.semibold(.title3))
        label.textColor = .coolgray900
        return label
    }()
    
    private let emotionImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .icNoRecord
        return image
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "너의 감정이 궁금해!"
        label.applyFontCase(.semibold(.caption1))
        label.textColor = .coolgray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recordButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .coolgray200
        config.baseForegroundColor = .gray900
        config.imagePlacement = .trailing
        config.imagePadding = 4
        config.cornerStyle = .capsule
        config.image = .icChevronRight
        
        var title = AttributedString("감정 기록하기")
        title.font = FontCase.bold(.caption1).toUIFont
        config.attributedTitle = title

        var imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        config.preferredSymbolConfigurationForImage = imageConfig
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false

        // 액션 추가
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        
        return button
    }()

    
    private func setupConstraints() {
        addSubview(circleView)
        addSubview(lastLabel)
        addSubview(aboutDiaryLabel)
        addSubview(emotionImage)
        addSubview(questionLabel)
        addSubview(recordButton)
        
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lastLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 8),
            lastLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            aboutDiaryLabel.topAnchor.constraint(equalTo: lastLabel.bottomAnchor, constant: 4),
            aboutDiaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emotionImage.topAnchor.constraint(equalTo: aboutDiaryLabel.bottomAnchor, constant: 12),
            emotionImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: emotionImage.bottomAnchor, constant: 12),
            questionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}


extension PastNoneRecordComponentView {
    @objc func recordButtonTapped() {
        buttonTapped?()
    }
}
