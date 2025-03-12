//
//  DiaryContentView.swift
//  Home
//
//  Created by 박서연 on 2024/11/27.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Models

// DiaryContentView에서 새로운 컴포넌트를 활용
public class DiaryContentView: UIView {
    
    private var textViews: [DiaryContentViewComponent] = []
    let eventView = DiaryContentViewComponent(title: "사건", content: "")
    let thinkView = DiaryContentViewComponent(title: "행동", content: "")
    let resultView = DiaryContentViewComponent(title: "결과", content: "")
    
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        mainStackView.addArrangedSubview(eventView)
        mainStackView.addArrangedSubview(thinkView)
        mainStackView.addArrangedSubview(resultView)
        
        textViews.append(eventView)
        textViews.append(thinkView)
        textViews.append(resultView)
    }
    
    func setTextViewsEditable(_ editable: Bool) {
        textViews.forEach { $0.setEditable(editable) }
    }
    
    func updateData(event: String, think: String, result: String) {
        eventView.updateContentTextViewText(data: event)
        thinkView.updateContentTextViewText(data: think)
        resultView.updateContentTextViewText(data: result)
    }
}


/// 결과 화면의 사건, 행동, 결과를 그리는 공통 컴포넌트 입니다.

class DiaryContentViewComponent: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.subheadline))
        label.textColor = .coolgray600
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = FontCase.regular(.subheadline).toUIFont
        textView.textColor = .coolgray800
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        return textView
    }()
    
    init(title: String, content: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.contentTextView.text = content
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentTextView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func setEditable(_ editable: Bool) {
        contentTextView.isEditable = editable
    }
    
    func updateContentTextViewText(data: String) {
        contentTextView.text = data
    }
}

