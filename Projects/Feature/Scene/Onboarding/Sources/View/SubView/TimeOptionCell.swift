//
//  TimeOptionCell.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class TimeOptionCell: UICollectionViewCell {
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // Container View
        containerView.backgroundColor = .pureWhite
        containerView.layer.cornerRadius = 4
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Icon Image View
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .coolgray800
        containerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        titleLabel.font = FontCase.bold(.body).toUIFont
        titleLabel.textAlignment = .center
        titleLabel.textColor = .coolgray800
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Time Label
        timeLabel.font = FontCase.semibold(.caption1).toUIFont
        timeLabel.textAlignment = .center
        timeLabel.textColor = .coolgray400
        containerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    public func configure(with option: TimeOption, isSelected: Bool, customTimeText: String = "") {
        titleLabel.text = option.title
        
        // 커스텀 시간 텍스트가 제공된 경우 그것을 사용
        if option == .custom && !customTimeText.isEmpty {
            timeLabel.text = customTimeText
        } else {
            timeLabel.text = option.time
        }
        
        iconImageView.image = option.icon
        
        if isSelected {
            containerView.backgroundColor = .coolgray50
        } else {
            containerView.backgroundColor = .white
        }
    }
}
