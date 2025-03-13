//
//  CustomTextField.swift
//  DesignSystem
//
//  Created by cha_nyeong on 3/10/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation
import UIKit

public class FloatingLabelTextField: UIView {
    
    // MARK: - Private Properties
    private let containerView = UIView()
    private let textField = UITextField()
    private let floatingLabel = UILabel()
    private let statusButton = UIButton(type: .system)
    
    // MARK: - Public Properties

    /// 닉네임 상태를 표시하는 열거형
    public enum NicknameStatus {
        case available      // 사용 가능
        case unavailable    // 사용 불가능
        case empty          // 입력 없음
    }
    
    /// 현재 닉네임 상태 (상태에 따라 아이콘이 변경됨)
    public var nicknameStatus: NicknameStatus = .empty {
        didSet {
            updateStatusButton()
        }
    }
    
    /// 입력된 텍스트 값
    public var text: String? {
        get { return textField.text }
        set {
            textField.text = newValue
            if let text = newValue, !text.isEmpty {
                // 텍스트가 있으면 상태 확인 함수 호출
                checkNicknameStatus?(text)
            } else {
                nicknameStatus = .empty
            }
        }
    }
    
    /// 상단 플레이스홀더 텍스트
    public var placeholderText: String = "최소 2~12자 이내의 닉네임을 설정해주세요" {
        didSet {
            floatingLabel.text = placeholderText
        }
    }
    
    /// 텍스트 필드 폰트
    public var textFont: UIFont = FontCase.semibold(.title3).toUIFont {
        didSet {
            textField.font = textFont
        }
    }
    
    /// 플레이스홀더 폰트
    public var placeholderFont: UIFont = FontCase.regular(.caption2).toUIFont {
        didSet {
            floatingLabel.font = placeholderFont
        }
    }
    
    /// 플레이스홀더 색상
    public var placeholderColor: UIColor = .coolgray500 {
        didSet {
            floatingLabel.textColor = placeholderColor
        }
    }
    
    /// 텍스트 필드 텍스트 색상
    public var textColor: UIColor = .coolgray500 {
        didSet {
            textField.textColor = textColor
        }
    }
    
    /// 테두리 색상
    public var borderColor: UIColor = .coolgray300 {
        didSet {
            containerView.layer.borderColor = borderColor.cgColor
        }
    }
    
    /// 닉네임 상태 확인을 위한 콜백
    public var checkNicknameStatus: ((String) -> Void)?
    
    /// 텍스트 변경 이벤트를 감지하는 콜백
    public var textDidChangeHandler: ((String?) -> Void)?
    
    /// 리턴 키를 눌렀을 때 호출되는 콜백
    public var returnKeyHandler: (() -> Void)?
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        // 컨테이너 뷰 설정
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 6
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = borderColor.cgColor
        
//        // 그림자 추가
//        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowOpacity = 0.2
//        containerView.layer.shadowRadius = 2
//        containerView.layer.masksToBounds = false
        
        // 플로팅 레이블 설정
        floatingLabel.text = placeholderText
        floatingLabel.font = placeholderFont
        floatingLabel.textColor = placeholderColor
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 텍스트 필드 설정
        textField.placeholder = ""
        textField.font = textFont
        textField.textColor = textColor
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // 상태 버튼 설정
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        updateStatusButton()
        
        // 컨테이너에 추가
        addSubview(containerView)
        containerView.addSubview(floatingLabel)
        containerView.addSubview(textField)
        containerView.addSubview(statusButton)
        
        // 컨테이너 뷰 제약조건
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // 플로팅 레이블 제약조건
        NSLayoutConstraint.activate([
            floatingLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            floatingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            floatingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
        
        // 텍스트 필드 제약조건
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: floatingLabel.bottomAnchor, constant: 6),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: statusButton.leadingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        // 상태 버튼 제약조건
        NSLayoutConstraint.activate([
            statusButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            statusButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            statusButton.widthAnchor.constraint(equalToConstant: 24),
            statusButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func updateStatusButton() {
        switch nicknameStatus {
        case .available:
            // 사용 가능한 경우 녹색 체크마크
            statusButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            statusButton.tintColor = .systemGreen
        case .unavailable:
            // 사용 불가능한 경우 빨간색 X
            statusButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            statusButton.tintColor = .systemRed
        case .empty:
            // 비어있는 경우 아무것도 표시하지 않음
            statusButton.setImage(nil, for: .normal)
        }
    }
    
    @objc private func textFieldDidChange() {
        let text = textField.text
        textDidChangeHandler?(text)
        
        guard let text = text, !text.isEmpty else {
            nicknameStatus = .empty
            return
        }
        
        // 상태 확인 콜백이 설정되어 있으면 호출
        checkNicknameStatus?(text)
    }
    
    // MARK: - Public Methods
    
    /// 텍스트 필드에 포커스
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    /// 텍스트 필드에서 포커스 제거
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    /// 텍스트 필드 비우기
    public func clear() {
        textField.text = ""
        nicknameStatus = .empty
    }
    
    /// 텍스트 필드 활성화/비활성화
    public func setEnabled(_ enabled: Bool) {
        textField.isEnabled = enabled
        alpha = enabled ? 1.0 : 0.5
    }
    
    /// 키보드 타입 설정
    public func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    /// 리턴 키 타입 설정
    public func setReturnKeyType(_ type: UIReturnKeyType) {
        textField.returnKeyType = type
    }
    
    /// 자동 수정 설정
    public func setAutocorrectionType(_ type: UITextAutocorrectionType) {
        textField.autocorrectionType = type
    }
    
    /// 텍스트 자동 대문자화 설정
    public func setAutocapitalizationType(_ type: UITextAutocapitalizationType) {
        textField.autocapitalizationType = type
    }
}

// MARK: - UITextFieldDelegate
extension FloatingLabelTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        returnKeyHandler?()
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // 필요한 경우 여기에 로직 추가
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // 필요한 경우 여기에 로직 추가
    }
}
