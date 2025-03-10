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

public class DiaryContentView: UIView {
    
    var textViews: [UITextView] = []
    
    // 3개의 view(제목 + 내용 스택뷰)를 담을 총괄 스택뷰
    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.backgroundColor = .clear
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupViewComponent(title: String, content: String) -> UIView {
        // 각각의 제목 + 내용 스택뷰를 담을 View
        let containerView = UIView()
        containerView.layer.cornerRadius = 6
        
        // 제목 + 내용 스택뷰
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.applyFontCase(.bold(.subheadline))
        titleLabel.textColor = .coolgray600
        
        let contentTextView = UITextView()
        contentTextView.text = content
        contentTextView.font = FontCase.regular(.subheadline).toUIFont
        contentTextView.textColor = .coolgray800
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = false
        contentTextView.textContainer.lineFragmentPadding = 0  // 텍스트 패딩 제거
        contentTextView.textContainerInset = .zero  // 컨테이너 인셋 제거
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentTextView)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        ])
        
        textViews.append(contentTextView)
        
        return containerView
    }
    
    func configure(event: String, think: String, result: String) {
        let eventView = setupViewComponent(title: "사건", content: event)
        let thinkView = setupViewComponent(title: "행동", content: think)
        let resultView = setupViewComponent(title: "결과", content: result)
        
        mainStackView.addArrangedSubview(eventView)
        mainStackView.addArrangedSubview(thinkView)
        mainStackView.addArrangedSubview(resultView)
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setTextViewsEditable(_ editable: Bool) {
        textViews.forEach { $0.isEditable = editable }
    }
}
