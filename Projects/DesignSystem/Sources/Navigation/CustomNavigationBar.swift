//
//  CustomNavigationBar.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/10/08.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public enum NavigationBarType {
    case titleOnly
    case LRButtonWithTitle
    case LButtonWithTitle
    case LButtonWithLTitle
    case LRButtonWithLTitle
    case LButtonRTitle
}

public class CustomNavigationBar: UIView {

    private let titleLabel = UILabel()
    private let leftButton = UIButton()
    private let rightButton = UIButton()
    private let rightLabel = UILabel()
    private var config = UIButton.Configuration.filled()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configure(
        title: String?,
        font: UIFont? = FontCase.regular(.title3).toUIFont,
        rightImage: UIImage? = nil,
        leftAction: Selector? = nil,
        rightAction: Selector? = nil,
        RButtonTitle: String? = nil,
        RButtonTitleFont: FontCase = FontCase.semibold(.footnote),
        target: Any?,
        type: NavigationBarType
    ) {
        titleLabel.text = title
        titleLabel.font = font

        // 네비게이션 바 타입에 따라 버튼 표시/숨김
        switch type {
        case .titleOnly:
            titleLabel.text = title
            titleLabel.font = font
            addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
        case .LRButtonWithTitle:
            leftButton.setImage(.icArrowBack, for: .normal)
            titleLabel.text = title
            titleLabel.font = font
            addSubview(titleLabel)
            addSubview(leftButton)
            addSubview(rightButton)
            
            if let action = leftAction {
                leftButton.addTarget(target, action: action, for: .touchUpInside)
            }
            
            if let image = rightImage, let action = rightAction {
                rightButton.setImage(image, for: .normal)
                rightButton.addTarget(target, action: action, for: .touchUpInside)
            }
            
            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                rightButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
        case .LButtonWithTitle:
            leftButton.setImage(.icArrowBack, for: .normal)
            titleLabel.text = title
            titleLabel.font = font
            addSubview(titleLabel)
            addSubview(leftButton)
            
            if let action = leftAction {
                leftButton.addTarget(target, action: action, for: .touchUpInside)
            }

            NSLayoutConstraint.activate([
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                leftButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
        case .LButtonWithLTitle:
            leftButton.setImage(.icArrowBack, for: .normal)
            titleLabel.text = title
            titleLabel.font = font
            addSubview(titleLabel)
            addSubview(leftButton)
            
            if let action = leftAction {
                leftButton.addTarget(target, action: action, for: .touchUpInside)
            }

            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 4),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                leftButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
        case .LRButtonWithLTitle:
            leftButton.setImage(.icArrowBack, for: .normal)
            titleLabel.text = title
            titleLabel.font = font
            
            if let rButtonTitle = RButtonTitle {
                var attributedTitle = AttributedString(rButtonTitle)
                attributedTitle.font = FontCase.semibold(.footnote).toUIFont
                attributedTitle.foregroundColor = UIColor.coolgray50
                config.attributedTitle = attributedTitle
            }
            
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
            config.baseBackgroundColor = UIColor.coolgray800
            rightButton.configuration = config
            
            addSubview(titleLabel)
            addSubview(leftButton)
            addSubview(rightButton)
            
            if let action = leftAction {
                leftButton.addTarget(target, action: action, for: .touchUpInside)
            }
            
            if let image = rightImage, let action = rightAction {
                rightButton.setImage(image, for: .normal)
                rightButton.addTarget(target, action: action, for: .touchUpInside)
            }

            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 4),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
        case .LButtonRTitle:
            leftButton.setImage(.icArrowBack, for: .normal)
            rightLabel.text = title
            rightLabel.font = font
            rightLabel.textColor = .coolgray600
            addSubview(leftButton)
            addSubview(rightLabel)
            
            if let action = leftAction {
                leftButton.addTarget(target, action: action, for: .touchUpInside)
            }
            
            if let image = rightImage, let action = rightAction {
                rightButton.setImage(image, for: .normal)
                rightButton.addTarget(target, action: action, for: .touchUpInside)
            }
            
            NSLayoutConstraint.activate([
                leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
        }
    }
}
