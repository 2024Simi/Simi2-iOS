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
    let characterView = CharacterResultView()
    let diaryContentView = DiaryContentView()
    
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
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stringStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()
}

// MARK: - Layout Extenison
extension ResultViewController {
    private func configureLayout() {
        diaryContentView.configure(
            event: "푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는",
            behavior: "푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는 너에게 나는 그런 사람이고 싶다. 들판에 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 핀 작은 풀꽃같이 바람에 날리는 어여쁜 민들레같이 잔잔한 미소와 작은 행복을 주는 사람 너에게 나는 그런 사람이고 싶다..푸른하늘처럼 투명하게 새벽공기처럼 청아하게 언제나 파란 희망으로 다가서는",
            result: "언제나 파란 희망으로 다가서는 너에언제나 파란 희망으로 다가서는 너에언제나 파란 희망으로 다가서는 너에언제나 파란 희망으로 다가서는 너에언제나 파란 희망으로 다가서는 너에"
        )
        
        characterView.configure(mainEmotion: viewModel.resultMessage.mainEmotion, empathyMessage: viewModel.resultMessage.message, stackViewColor: viewModel.resultMessage.color, image: viewModel.resultMessage.mainImage)
        
        totalScrollView.backgroundColor = .backgroundColor
        characterView.backgroundColor = UIColor.white
        diaryContentView.translatesAutoresizingMaskIntoConstraints = false
        characterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalScrollView)
        
        setupEmotionLabels()
        totalScrollView.addSubview(characterView)
        totalScrollView.addSubview(emotionsScrollView)
        totalScrollView.addSubview(diaryContentView)
        
        NSLayoutConstraint.activate([
            totalScrollView.topAnchor.constraint(equalTo: customBar.bottomAnchor),
            totalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            totalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            characterView.topAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.topAnchor),
            characterView.leadingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.leadingAnchor),
            characterView.trailingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.trailingAnchor),
            
            emotionsScrollView.topAnchor.constraint(equalTo: characterView.bottomAnchor),
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
            
            diaryContentView.topAnchor.constraint(equalTo: emotionsScrollView.bottomAnchor),
            diaryContentView.leadingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            diaryContentView.trailingAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            diaryContentView.bottomAnchor.constraint(equalTo: totalScrollView.contentLayoutGuide.bottomAnchor),
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
        viewModel.backButton?()
    }
    
    @objc func tappedRAction() {
        print(viewModel.isEditing ? "수정끝" : "수정시작")
        diaryContentView.setTextViewsEditable(viewModel.isEditing ? false : true)
        viewModel.isEditing.toggle()
        customBar.updateRightButtonTitle(viewModel.isEditing ? "완료" : "수정하기")
    }
}
