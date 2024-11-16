//
//  CustomTextfield.swift
//  DesignSystem
//
//  Created by cha_nyeong on 10/22/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Common

final public class CustomTextfield: UIView, UIComponentBased {
    /// TextField 최대 글자수
    var maxLength = 0
    /// return 버튼 눌렀을 때의 completion
    /// 사용법
    /// ```swift
    ///    textfield.returnValueAction = { text in
    ///    print(text) }
    /// ```
    
    public var returnValueAction: ((String) -> Void)?
    /// 값이 변했을 때 접근하는 completion
    /// 사용법
    /// ```swift
    ///    textfield.didChangeTextAction = { text in
    ///    print(text) }
    /// ```
    public var didChangeTextAction: ((String) -> Void)?
    
    var editable: Bool
    /// 작성 가능한 상태
    /// false일 경우 수정 불가능한 읽기 전용 상태
    /// true일 경우 수정 가능한 TextField 형태

    // 텍스트 필드의 상태
    var status: InputTextFieldStatus = .valid {
        didSet {
            updateBorderColor()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = FontCase.regular(.caption2).toUIFont
        v.textColor = editable ? .gray500 : .gray300
        
        return v
    }()
    
    lazy var textField: UITextField = {
        let v = UITextField()
        v.font = FontCase.semibold(.title3).toUIFont
        v.textColor = .gray900
        v.backgroundColor = .clear
        v.placeholder = "기본"
        v.setPlaceholder(color: editable ? .gray500 : .gray300)
        v.delegate = self
        v.rightViewMode = .whileEditing // 편집 중일 때만 우측에 x 버튼이 표시됨
        v.rightView = clearButton
        
        return v
    }()
    
    lazy var textLabel: UILabel = {
        let v = UILabel()
        v.font = FontCase.regular(.caption2).toUIFont
        v.textColor = .gray500
        
        return v
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.icCheckSmall, for: .normal)
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        return button
    }()
    
    /// title명, placeholder, maxLength 지정
    public init(
        title: String,
        placeholder: String,
        maxLength: Int,
        editable: Bool
    ) {
        self.editable = editable
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        self.maxLength = maxLength
        self.attribute()
        self.layout()
        self.textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func attribute() {
        // 최대 글자수 이상 입력 못하게 설정
        self.textField.addTarget(self, action: #selector(self.didChangeTextfieldText(_:)), for: .editingChanged)
    }
    
    public func layout() {
        // 배경 뷰의 모양 설정
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray200.cgColor
        
        // 서브뷰 추가
        addSubviews(titleLabel, textLabel, textField)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // titleLabel는 배경 뷰의 (12,8,-10,?)
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            // textField는 titleLabel의 (6,8,-10,-10)
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            // textField는 titleLabel의 (6,8,-10,-10)
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        // 수정 여부에 따른 라벨과 필드 변경
        if editable {
            textField.isHidden = false
            textLabel.isHidden = true
        } else {
            textField.isHidden = true
            textLabel.isHidden = false
        }
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        self.textField.becomeFirstResponder()
    }
    
    /// textField의 값을 설정해주는 함수
    public func setTextFieldValue(text: String) {
        self.textField.text = text
    }
    
    /// textField의 값을 가져오는 함수
    public func getTextFieldValue() -> String {
        return textField.text ?? ""
    }
    
    // 테두리 색상 업데이트
    private func updateBorderColor() {
        switch status {
        case .valid:
            self.layer.borderColor = UIColor.gray200.cgColor
        case .invalid:
            self.layer.borderColor = UIColor.pink200.cgColor
        }
    }
    
    @objc private func didChangeTextfieldText(_ textField: UITextField) {
        if let text = self.textField.text {
            /// 초과되는 텍스트 입력 못하도록 한다
            if text.count >= self.maxLength {
                let index = text.index(text.startIndex, offsetBy: self.maxLength)
                let newString = text[text.startIndex..<index]
                self.textField.text = String(newString)
            }
            self.didChangeTextAction?(self.textField.text ?? "")
        }
    }
    
    @objc private func clearTextField() {
        self.textField.text = ""
        self.didChangeTextAction?("")
    }
}

extension CustomTextfield: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.returnValueAction?(textField.text ?? "")
        return true
    }
}
