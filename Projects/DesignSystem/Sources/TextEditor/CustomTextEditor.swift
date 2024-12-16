//
//  CustomTextEditor.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public class CustomTextEditor: UIView {
    
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
    
    public var placeholder: String? {
        get { placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = FontCase.regular(.callout).toUIFont
        textView.textColor = .coolgray600
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coolgray400
        label.applyFontCase(.semibold(.footnote))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let placeholderLabel: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.textColor = .coolgray200
        textView.font = FontCase.regular(.callout).toUIFont
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextView()
        setupPlaceholder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
        setupPlaceholder()
    }

    private func setupTextView() {
        textView.delegate = self
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(countLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func setupPlaceholder() {
        addSubview(placeholderLabel)
    
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func updateCharacterCount() {
        let currentCount = textView.text.count
        countLabel.text = "(\(currentCount)/\(maxCharacterCount))"
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
