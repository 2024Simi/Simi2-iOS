//
//  AllAgreeView.swift
//  Home
//
//  Created by cha_nyeong on 11/19/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Common

public final class AllAgreeView: UIView {
    // MARK: - UI Components
    private let checkImageView: UIImageView = {
        let imageView = UIImageView(image: .icDisableCheck)
//        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "전체동의"
        titleLabel.font = FontCase.bold(.body).toUIFont
        titleLabel.textColor = .coolgray800
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "서비스 이용을 위해 아래 약관에 모두 동의합니다."
        subtitleLabel.font = FontCase.regular(.footnote).toUIFont
        subtitleLabel.textColor = .coolgray500
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    // MARK: - Properties
    var isChecked: Bool = false {
        didSet {
            updateCheckboxState()
        }
    }
    
    var onTap: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubviews(checkImageView, titleLabel, subtitleLabel)
        
        NSLayoutConstraint.activate([
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    private func updateCheckboxState() {
        checkImageView.image =
        isChecked ? .icEnableCheck : .icDisableCheck
    }
    
    @objc private func viewTapped() {
        onTap?()
    }
}
