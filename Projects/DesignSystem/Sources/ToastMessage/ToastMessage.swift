//
//  ToastMessage.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/30.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public enum ToastCase {
    case success
    case failure
    
    var color: UIColor {
        switch self {
        case .success:
            return .coolgray600
        case .failure:
            return .systemRed
        }
    }
    
    var image: UIImage {
        switch self {
        case .success:
            return .icCheckSmall
        case .failure:
            return .icCloseSmall
        }
    }
}

public enum ToastPosition {
    case up
    case down
}

public class ToastMessage: UIView {

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .white
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 6
        setupConstraints()
    }

    func setupConstraints() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(messageLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    func configure(message: String, type: ToastCase) {
        messageLabel.text = message
        imageView.image = type.image
        self.backgroundColor = type.color
    }
}
