//
//  CusotmAlert.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public enum AlertCase {
    case TitleContentDButton//(title: String, content: String, LButton: String, RButton: String) // [Confirm : 제목 + 내용(2줄) + 버튼(2개) ]
    case TitleContentSButton//(title: String, content: String, SButton: String) // [Confirm : 제목 + 내용(2줄) + 버튼(1개) ]
    case TitleSButton//(title: String, SButton: String) // [Confirm : 제목 + 버튼(1개)]
}

public class CusotmAlert: UIView {
    
    // MARK: - Properties
    public var SButtonAction: (() -> Void)?
    public var RButtonAction: (() -> Void)?
    public var LButtonAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyFontCase(.semibold(.title2))
        label.textColor = .gray900
        label.numberOfLines = 0
        return label
    }()
    
    private let contentLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray800
        label.applyFontCase(.semibold(.footnote))
        label.numberOfLines = 0
        return label
    }()
    
    private let LButtonView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapActionLButton), for: .touchUpInside)
        return button
    }()
    
    private let RButtonView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapActionRButton), for: .touchUpInside)
        return button
    }()
    
    private let SButtonView: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("OK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapActionSButton), for: .touchUpInside)
        return button
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    public func configure(
        title: String,
        content: String? = nil,
        SButton: String? = nil,
        RButton: String? = nil,
        LButton: String? = nil,
        alertCase: AlertCase
    ) {
        
        switch alertCase {
        case .TitleContentDButton:
            setupTitleContentDButton(title: title, content: content, LButton: LButton, RButton: RButton)
        case .TitleContentSButton:
            setupTitleContentSButton(title: title, content: content, SButton: SButton)
        case .TitleSButton:
            setupTitleSButton(title: title, content: content, SButton: SButton)
        }

    }
    
    // MARK: - Actions
    @objc private func didTapActionSButton() {
        SButtonAction?()
    }
    
    @objc private func didTapActionRButton() {
        RButtonAction?()
    }
    
    @objc private func didTapActionLButton() {
        LButtonAction?()
    }
}

extension CusotmAlert {
    
    func setupTitleContentDButton(title: String, content: String?, LButton: String?, RButton: String?) {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(contentLable)
        
        buttonStackView.addArrangedSubview(LButtonView)
        buttonStackView.addArrangedSubview(RButtonView)
        
        totalStackView.addArrangedSubview(labelStackView)
        totalStackView.addArrangedSubview(buttonStackView)
        
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            totalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            LButtonView.heightAnchor.constraint(equalToConstant: 42),
            RButtonView.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        // 값 설정
        titleLabel.text = title
        contentLable.text = content
        LButtonView.setTitle(LButton, for: .normal)
        RButtonView.setTitle(RButton, for: .normal)
        
        // 색상 설정
        LButtonView.setTitleColor(.gray700, for: .normal)
        LButtonView.backgroundColor = .gray100
        RButtonView.setTitleColor(.white, for: .normal)
        RButtonView.backgroundColor = .gray600
        
        LButtonView.layer.cornerRadius = 8
        RButtonView.layer.cornerRadius = 8
    }
    
    func setupTitleContentSButton(title: String, content: String?, SButton: String?) {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(contentLable)
        totalStackView.addArrangedSubview(labelStackView)
        totalStackView.addArrangedSubview(SButtonView)
        
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            totalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            SButtonView.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        // 값 설정
        titleLabel.text = title
        contentLable.text = content
        SButtonView.setTitle(SButton, for: .normal)
        
        // 색상 설정
        SButtonView.backgroundColor = .gray600
        SButtonView.setTitleColor(.white, for: .normal)
        SButtonView.layer.cornerRadius = 8
    }
    
    func setupTitleSButton(title: String, content: String?, SButton: String?) {
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(SButtonView)
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            totalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            SButtonView.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        // 값 설정
        titleLabel.text = title
        SButtonView.setTitle(SButton, for: .normal)
        
        // 색상 설정
        SButtonView.backgroundColor = .gray600
        SButtonView.setTitleColor(.white, for: .normal)
        SButtonView.layer.cornerRadius = 8
    }
}


