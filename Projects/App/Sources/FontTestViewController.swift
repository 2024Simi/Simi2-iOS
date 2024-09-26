//
//  AppDumy.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import UIKit
import DesignSystem

class FontTestViewController: UIViewController, UITextFieldDelegate {
    
    var buttonTest: Bool = false
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "hello"
        let font = FontCase.bold(.largeTitle)
        label.applyFontCase(font)
        label.textColor = .pink900
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .icArrowUp
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let button: CommonButton = {
        let button = CommonButton()
        button.text = "ButtonTest"
        button.isDisabled = true
        return button
    }()
    
    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputTextField.delegate = self
        
        button.tap {
            print("Button tapped...")
        }
    }
    
    func setup() {
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(inputTextField)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            inputTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            button.isDisabled = false
        } else {
            button.isDisabled = true
        }
    }
}
