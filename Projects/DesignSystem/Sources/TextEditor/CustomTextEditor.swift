//
//  CustomTextEditor.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public class CustomTextEditor: UIView {
    private let textView = UITextView()
    private let characterCountLabel = UILabel()
    private let placeholderLabel = UITextView()
    
    public var font: UIFont = FontCase.regular(.callout).toUIFont
    
    public var text: String {
        get { textView.text }
        set {
            textView.text = newValue
            updateCharacterCount()
            textViewDidChange(textView)
        }
    }
    
    public var textChangedCallback: ((String) -> Void)?
    public var textColor: UIColor = .black {
        didSet {
            textView.textColor = textColor
        }
    }
    
    public var maxCharacterCount: Int = 300 {
        didSet {
            updateCharacterCount()
        }
    }
    
    // MARK: - placeholder
    public var placeholder: String? {
        get { placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    private func setupPlaceholder() {
        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.textColor = .coolgray200
        placeholderLabel.font = font
        placeholderLabel.backgroundColor = .clear
        addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextView()
        setupPlaceholder()
        setupCharacterCountLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
        setupPlaceholder()
        setupCharacterCountLabel()
    }

    private func setupTextView() {
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = font
        textView.textColor = textColor
        textView.showsVerticalScrollIndicator = false
        
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupCharacterCountLabel() {
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        characterCountLabel.font = UIFont.systemFont(ofSize: 14)
        characterCountLabel.textColor = .gray
        characterCountLabel.textAlignment = .right
        characterCountLabel.text = "(\(textView.text.count)/\(maxCharacterCount))"
        
        addSubview(characterCountLabel)
        
        NSLayoutConstraint.activate([
            characterCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            characterCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func updateCharacterCount() {
        let currentCount = textView.text.count
        characterCountLabel.text = "(\(currentCount)/\(maxCharacterCount))"
    }
    
    @objc private func dismissKeyboard() {
        textView.resignFirstResponder()
    }
}

extension CustomTextEditor: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
        textChangedCallback?(textView.text)
        
        if text.count == 0 {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
    }
}
