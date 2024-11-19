//
//  BehaviorViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class BehaviorViewController: UIViewController {
    
    public var customBar: CustomNavigationBar
    public let viewModel: BehaviorViewModel
    
    public init(
        viewModel: BehaviorViewModel,
        customBar: CustomNavigationBar = CustomNavigationBar()
    ) {
        self.viewModel = viewModel
        self.customBar = customBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraint()
        setupNavigationBar()
        setupButton()
        setupKeyboard()
        bindViewModel()
    }
    
    private let caseLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.footnote))
        label.textColor = .pureBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.title2))
        label.textColor = .coolgray900
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: CommonButton = {
        let button = CommonButton()
        button.text = "다음으로"
        button.isDisabled = true
        return button
    }()
    
    private let textEditor: CustomTextEditor = {
        let editor = CustomTextEditor()
        editor.text = ""
        editor.translatesAutoresizingMaskIntoConstraints = false
        return editor
    }()
    
    private let cancelButton: CancelButton = {
        let button = CancelButton()
        button.text = "다음에 할래요"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let textButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 100
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.image = .icSample
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let assistanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coolgray600
        label.font = FontCase.semibold(.footnote).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func bindViewModel() {
        caseLabel.text = viewModel.titleText
        questionLabel.text = viewModel.questionText
        textEditor.placeholder = viewModel.placeholderText
        assistanceLabel.text = viewModel.assistance
    }
}

extension BehaviorViewController {
    /// 레이아웃 관련
    private func setupStackView() {
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(nextButton)
        
        textButtonStackView.addArrangedSubview(textEditor)
        textButtonStackView.addArrangedSubview(buttonStackView)
    }
    
    private func setupConstraint() {
        setupNavigationBar()
        setupStackView()
        view.addSubview(caseLabel)
        view.addSubview(questionLabel)
        view.addSubview(characterImage)
        view.addSubview(assistanceLabel)
        view.addSubview(textButtonStackView)
        
        textEditor.layer.borderColor = UIColor.coolgray300.cgColor
        textEditor.layer.cornerRadius = 10
        textEditor.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            caseLabel.topAnchor.constraint(equalTo: customBar.bottomAnchor),
            caseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            caseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            questionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            characterImage.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            assistanceLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            assistanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            assistanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            
            textButtonStackView.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor, constant: 25),
            textButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            textButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            textButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
        
        if textEditor.text.count > 0, !textEditor.text.isEmpty {
            nextButton.isDisabled = false
        } else {
            nextButton.isDisabled = true
        }
    }
    
    // MARK: - Navigation 관련
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        view.addSubview(customBar)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customBar.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        customBar.configure(
            title: "(2/4)",
            font: FontCase.bold(.footnote).toUIFont,
            leftAction: #selector(tappedLAction),
            target: self,
            type: .LButtonRTitle)
    }
    
    @objc private func tappedLAction() {
        viewModel.backButtonTapped()
    }
    
    private func setupKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        textEditor.textChangedCallback = { [weak self] text in
            self?.updateNextButtonState(with: text)
        }
    }
}

// MARK: - Button Action
extension BehaviorViewController {
    private func setupButton() {
        cancelButton.tap {
            print("cancel button tapped")
        }
        
        nextButton.tap {
            print("next button tapped")
            self.viewModel.nextButtonTapped(text: self.textEditor.text)
        }
    }
    
    private func updateNextButtonState(with text: String) {
        if text.count > 0 {
            nextButton.isDisabled = false
        } else {
            nextButton.isDisabled = true
        }
    }
}
