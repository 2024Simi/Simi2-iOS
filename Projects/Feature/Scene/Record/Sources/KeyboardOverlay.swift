//
//  KeyboardOverlay.swift
//  Home
//
//  Created by 박서연 on 2024/12/16.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class KeyboardOverlayView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 6
        setupConstraints()
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 6
        setupConstraints()
        textView.delegate = self
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내용 입력"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = .icArrowDown
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = FontCase.regular(.subheadline).toUIFont
        textView.textColor = .coolgray600
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .coolgray400
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(0/300)"
        label.textAlignment = .right
        return label
    }()
    
    let containStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    private func setupConstraints() {
        backgroundColor = .white
        containStack.addArrangedSubview(textView)
        containStack.addArrangedSubview(countLabel)
        
        addSubview(titleLabel)
        addSubview(arrowImage)
        addSubview(dividerView)
        addSubview(containStack)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            arrowImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            arrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            dividerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            containStack.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 12),
            containStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func updateCountLabel(text: String) {
        let count = text.count
        countLabel.text = "(\(count)/300)"
    }
}

extension KeyboardOverlayView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        updateCountLabel(text: textView.text)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 300
    }
}
