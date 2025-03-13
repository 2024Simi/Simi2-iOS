//
//  RecordViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/18.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class EventViewController: UIViewController {

    public var customBar: CustomNavigationBar
    public let viewModel: EventViewModel

    public init(
        viewModel: EventViewModel,
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
        
        textEditor.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textEditorTapped))
        textEditor.addGestureRecognizer(tapGesture)
    }
    
    private var overlayView: KeyboardOverlayView?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    @objc public override func dismissKeyboard() {
        guard let inputText = overlayView?.textView.text else { return }
        self.textEditor.text = inputText
        view.endEditing(true)
    }
    
    private func bindViewModel() {
        caseLabel.text = viewModel.titleText
        questionLabel.text = viewModel.questionText
        textEditor.placeholder = viewModel.placeholderText
        assistanceLabel.text = viewModel.assistance
    }
}

// MARK: - 레이아웃 관련 코드
extension EventViewController {
    private func setupConstraint() {
        setupNavigationBar()
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(nextButton)
        
        view.addSubview(caseLabel)
        view.addSubview(questionLabel)
        view.addSubview(characterImage)
        view.addSubview(assistanceLabel)
        view.addSubview(textEditor)
        view.addSubview(buttonStackView)
        
        textEditor.layer.borderColor = UIColor.coolgray300.cgColor
        textEditor.layer.cornerRadius = 10
        textEditor.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            caseLabel.topAnchor.constraint(equalTo: customBar.bottomAnchor, constant: 16),
            caseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            caseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            questionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            characterImage.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            characterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            characterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            assistanceLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            assistanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            assistanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textEditor.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor, constant: 19),
            textEditor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textEditor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textEditor.heightAnchor.constraint(equalToConstant: 251),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
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
            title: "(1/4)",
            font: FontCase.bold(.footnote).toUIFont,
            leftAction: #selector(tappedLAction),
            target: self,
            type: .LButtonRTitle)
    }
    
    @objc private func tappedLAction() {
        viewModel.backButtonTapped()
    }
}

// MARK: - Keyboard에 따른 TextView
extension EventViewController {
    
    @objc private func textEditorTapped() {
        addOverlayView(keyboardHeight: 269)
    }
    
    private func setupKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        textEditor.textChangedCallback = { [weak self] text in
            self?.updateNextButtonState(with: text)
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
         addOverlayView(keyboardHeight: 269)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            self.removeOverlayView()
            self.view.layoutIfNeeded()
        }
    }

    private func addOverlayView(keyboardHeight: CGFloat) {
        guard overlayView == nil else { return }
        
        let overlay = KeyboardOverlayView()
        overlay.textView.text = textEditor.text
        overlay.textView.becomeFirstResponder()
        self.overlayView = overlay
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.layer.opacity = 0.5
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        view.addSubview(backgroundView)
        
        
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.heightAnchor.constraint(equalToConstant: keyboardHeight),
            backgroundView.topAnchor.constraint(equalTo: overlay.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func removeOverlayView() {
        overlayView?.removeFromSuperview()
        overlayView = nil
    }
}

// MARK: - Button Action
extension EventViewController {
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
