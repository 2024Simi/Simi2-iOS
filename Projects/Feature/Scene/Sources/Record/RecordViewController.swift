//
//  RecordViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/18.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public enum DiaryRecord: String {
    case event = "사건"
    case think = "생각"
    case behavior = "행동"
    case emotions = "감정"
    
    public var question: String {
        switch self {
        case .event:
            return "님의 하루가 궁금해요"
        case .think:
            return "님의 생각이 궁금해요"
        case .behavior:
            return "님의 행동이 궁금해요"
        case .emotions:
            return "님의 감정이 궁금해요"
        }
    }
    
    public var assistance: String {
        switch self {
        case .event:
            return "오늘 하루는 어땠어?"
        case .think:
            return "그때 어떤 생각이 들었어?"
        case .behavior:
            return "그래서 어떤 행동을 했어?"
        case .emotions:
            return "네가 느꼈던 감정을 고른다면 어떤 단어로 표현될까?"
        }
    }
    
    public var placeholder: String {
        switch self {
        case .event:
            return "예시를 보여드릴게요. \n오늘 회사에서 부장님한테 깨졌어. \n오늘 학교에서 친구랑 싸웠어 \n오늘 일어난 일에 대해서 적어주세요!"
        case .think:
            return "think placeholder"
        case .behavior:
            return "behavior placeholder"
        case .emotions:
            return "emotions placeholder"
        }
    }
}

public class RecordViewController: UIViewController {

    private let customBar = CustomNavigationBar()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraint()
        setupNavigationBar()
        setupButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        textEditor.textChangedCallback = { [weak self] text in
            self?.updateNextButtonState(with: text)
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateNextButtonState(with text: String) {
        if text.count > 0 {
            nextButton.isDisabled = false
        } else {
            nextButton.isDisabled = true
        }
    }
    
    private let caseLabel: UILabel = {
        let label = UILabel()
        label.text = "01. \(DiaryRecord.event.rawValue)"
        label.applyFontCase(.bold(.footnote))
        label.textColor = .pureBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = DiaryRecord.event.question
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
        editor.placeholder = DiaryRecord.event.placeholder
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
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupStackView() {
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(nextButton)
        
        textButtonStackView.addArrangedSubview(textEditor)
        textButtonStackView.addArrangedSubview(buttonStackView)
    }
    
    private func setupConstraint() {
        setupStackView()
        view.addSubview(customBar)
        view.addSubview(caseLabel)
        view.addSubview(questionLabel)
        view.addSubview(textButtonStackView)
        
        textEditor.layer.borderColor = UIColor.coolgray300.cgColor
        textEditor.layer.cornerRadius = 4
        textEditor.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            caseLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            caseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            caseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            questionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textButtonStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            textButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
        
        if textEditor.text.count > 0, !textEditor.text.isEmpty {
            nextButton.isDisabled = false
        } else {
            nextButton.isDisabled = true
        }
    }
}

extension RecordViewController {
    private func setupButton() {
        cancelButton.tap {
            print("cancel button tapped")
        }
        
        nextButton.tap {
            print("next button tapped")
        }
    }
}

extension RecordViewController {
    private func setupNavigationBar() {
        customBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customBar.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
