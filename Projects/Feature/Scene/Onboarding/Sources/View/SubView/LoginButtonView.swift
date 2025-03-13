//
//  LoginButtonView.swift
//  Home
//
//  Created by cha_nyeong on 12/2/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Common
import DesignSystem

final public class LoginButtonView: UIView {
    // MARK: - Properties
    
    private var tapHandler: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.semibold(.subheadline).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    init(image: UIImage?, title: String, backgroundColor: UIColor, titleColor: UIColor) {
        super.init(frame: .zero)
        
        setupView(image: image, title: title, backgroundColor: backgroundColor, titleColor: titleColor)
        setupLayout()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView(image: UIImage?, title: String, backgroundColor: UIColor, titleColor: UIColor) {
        self.layer.cornerRadius = 6
        self.backgroundColor = backgroundColor
        
        iconImageView.image = image
        titleLabel.text = title
        titleLabel.textColor = titleColor
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // containerView constraints
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // iconImageView constraints
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // titleLabel constraints
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupTapGesture() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc private func handleTap() {
        tapHandler?()
        
        // 탭 애니메이션 효과 추가
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1.0
            }
        }
    }
    
    // MARK: - Public Methods
    
    func setTapAction(completion: @escaping () -> Void) {
        self.tapHandler = completion
    }
}

