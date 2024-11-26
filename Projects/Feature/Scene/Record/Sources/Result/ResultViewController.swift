//
//  ResultViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Models

public class ResultViewController: UIViewController {

    public var customBar: CustomNavigationBar
    public var viewModel: ResultViewModel
    
    public init(
        customBar: CustomNavigationBar = CustomNavigationBar(),
        viewModel: ResultViewModel
    ) {
        self.customBar = customBar
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        configureLayout()
    }
    
    // MARK: - Setup UI
    private let characterImage: UIImageView = {
        let image = UIImageView()
        image.image = .icSample
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let emotionsScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
//        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceVertical = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let emotionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private let totalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
//        scrollView.isPagingEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stringStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
//        stackView.distribution = .fillEqually
        return stackView
    }()
}

// MARK: - Layout Extenison
extension ResultViewController {
    private func configureLayout() {
        setupEmotionLabels()
        totalScrollView.addSubview(emotionsScrollView)
        totalScrollView.backgroundColor = .backgroundColor
        view.addSubview(totalScrollView)
        
        let diaryContentView = DiaryContentView()
        diaryContentView.translatesAutoresizingMaskIntoConstraints = false
        totalScrollView.addSubview(diaryContentView)

        NSLayoutConstraint.activate([
            diaryContentView.topAnchor.constraint(equalTo: emotionsScrollView.bottomAnchor),
            diaryContentView.leadingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            diaryContentView.trailingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            diaryContentView.bottomAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        // 외부에서 데이터 주입
        diaryContentView.configure(
            event: "푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 사람이고 싶다..푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는",
            behavior: "푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 사람이고 싶다..푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 사람이고 싶다..푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 사람이고 싶다..푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는",
            result: "언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔"
        )
        
        NSLayoutConstraint.activate([
            // totalScrollView 제약
            totalScrollView.topAnchor.constraint(equalTo: customBar.bottomAnchor),
            totalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            // emotionsScrollView 제약
            emotionsScrollView.topAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.topAnchor),
            emotionsScrollView.leadingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.leadingAnchor),
            emotionsScrollView.trailingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.trailingAnchor),
            emotionsScrollView.heightAnchor.constraint(equalToConstant: 68),
            emotionsScrollView.widthAnchor.constraint(equalTo: totalScrollView.frameLayoutGuide.widthAnchor),
            
            // emotionsStack 제약
            emotionsStack.topAnchor.constraint(equalTo: emotionsScrollView.contentLayoutGuide.topAnchor, constant: 16),
            emotionsStack.leadingAnchor.constraint(equalTo: emotionsScrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            emotionsStack.trailingAnchor.constraint(equalTo: emotionsScrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            emotionsStack.bottomAnchor.constraint(equalTo: emotionsScrollView.bottomAnchor, constant: -12),
            emotionsStack.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
    }
    
    private func setupEmotionLabels() {
        for emotion in viewModel.diaryEntity.emotions {
            let labelColor = EmotionType.allCases.first { $0.detailEmotion.contains(emotion) }?.color
            let label = UILabel()
            label.text = emotion
            label.textColor = .coolgray700
            label.translatesAutoresizingMaskIntoConstraints = false
            label.applyFontCase(FontCase.semibold(.subheadline))
            label.backgroundColor = labelColor
            label.layer.cornerRadius = 6
            label.clipsToBounds = true
            label.textAlignment = .center
            
            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalToConstant: 85),
                label.heightAnchor.constraint(equalToConstant: 40)
            ])

            emotionsStack.addArrangedSubview(label)
        }
        emotionsScrollView.addSubview(emotionsStack)
        emotionsScrollView.backgroundColor = .backgroundColor
    }
    
    private func setupViewComponent(title: String, content: String) -> UIView {
        let titleLabel = UILabel()
        let contentLable = UILabel()
        let stackView = UIStackView()
        let view = UIView()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLable.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        contentLable.text = content
        titleLabel.applyFontCase(.bold(.subheadline))
        titleLabel.textColor = .coolgray600
        contentLable.applyFontCase(FontCase.regular(.subheadline))
        contentLable.textColor = .coolgray800
        
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLable)
        view.addSubview(stackView)
        
        return view
    }
}

// MARK: - NavigatonBar Extension
extension ResultViewController {
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
            title: "기록",
            font: FontCase.semibold(.body).toUIFont,
            leftAction: #selector(tappedLAction),
            rightAction: #selector(tappedRAction),
            RButtonTitle: "수정하기",
            target: self,
            type: .LRButtonWithLTitle
        )
    }
    
    @objc func tappedLAction() {
        
    }
    
    @objc func tappedRAction() {
        
    }
}

class DiaryContentView: UIView {
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
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.applyFontCase(.regular(.subheadline))
        contentLabel.textColor = .coolgray800
        contentLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
        return containerView
    }
    
    func configure(event: String, behavior: String, result: String) {
        let eventView = setupViewComponent(title: "사건", content: event)
        let behaviorView = setupViewComponent(title: "행동", content: behavior)
        let resultView = setupViewComponent(title: "결과", content: result)
        
        mainStackView.addArrangedSubview(eventView)
        mainStackView.addArrangedSubview(behaviorView)
        mainStackView.addArrangedSubview(resultView)
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
