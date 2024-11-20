//
//  EmotionsViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Models

public class EmotionViewController: UIViewController {
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var tappedEmotinoType: EmotionType = .happy
    private var emotionButtons: [UIButton] = []
    
    public let viewModel: EmotionViewModel
    public var customBar: CustomNavigationBar
    
    public init(
        viewModel: EmotionViewModel,
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
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        setupBindings()
        setupConstraints()
    }
    
    private let caseLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.footnote))
        label.textColor = .pureBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emotionTypeButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        button.text = "완료"
        button.isDisabled = true
        return button
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
    
    private let emotionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let buttonCellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}

// MARK: - layout setting
extension EmotionViewController {
    private func setupConstraints() {
        emotionStackView.addArrangedSubview(emotionTypeButtonStack)
        emotionStackView.addArrangedSubview(collectionView)
        bottomButtonStackView.addArrangedSubview(cancelButton)
        bottomButtonStackView.addArrangedSubview(nextButton)
        buttonCellStackView.addArrangedSubview(emotionStackView)
        buttonCellStackView.addArrangedSubview(bottomButtonStackView)

        view.addSubview(caseLabel)
        view.addSubview(questionLabel)
        view.addSubview(characterImage)
        view.addSubview(assistanceLabel)
        view.addSubview(buttonCellStackView)
        
        NSLayoutConstraint.activate([
            caseLabel.topAnchor.constraint(equalTo: customBar.bottomAnchor, constant: 16),
            caseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            caseLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            questionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            characterImage.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            characterImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            characterImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            assistanceLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10),
            assistanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            assistanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emotionStackView.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor, constant: 40),
            emotionStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emotionStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 228),
            
            buttonCellStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            buttonCellStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonCellStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        customBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customBar)
        
        NSLayoutConstraint.activate([
            customBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customBar.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        customBar.configure(
            title: "(4/4)",
            font: FontCase.bold(.footnote).toUIFont,
            leftAction: #selector(tappedLAction),
            target: self,
            type: .LButtonRTitle)
    }
    
    @objc private func tappedLAction() {
        viewModel.backButtonTapped()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        for emotion in EmotionType.allCases {
            let button = UIButton(type: .system)
            let buttonWidth = (view.bounds.width - 42) / 5
            button.tag = emotion.hashValue
            button.setTitle(emotion.rawValue, for: .normal)
            button.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
            button.setTitleColor(UIColor.coolgray800, for: .normal)
            button.backgroundColor = viewModel.selectedEmotion == emotion ? emotion.color : .clear
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 4
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
            
            button.addTarget(self, action: #selector(emotionButtonTapped(_:)), for: .touchUpInside)
            emotionTypeButtonStack.addArrangedSubview(button)
            emotionButtons.append(button)
        }
        
        let layout = UICollectionViewFlowLayout()
        let wordWidth = (view.bounds.width - 68) / 3 //56
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 18 // 12
        layout.itemSize = CGSize(width: wordWidth, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: EmotionCell.identifier)
        collectionView.dataSource = self
    }
    
    private func setupBindings() {
        caseLabel.text = viewModel.titleText
        questionLabel.text = viewModel.questionText
        assistanceLabel.text = viewModel.assistance
        
        viewModel.onDataUpdated = { [weak self] in
            self?.updateButtonColors()
            self?.collectionView.reloadData()
        }
    }
    
    private func updateButtonColors() {
        for button in emotionButtons {
            guard let emotion = EmotionType.allCases.first(where: { $0.hashValue == button.tag }) else { continue }
            button.backgroundColor = viewModel.selectedEmotion == emotion ? emotion.color : .clear
        }
    }
    
    @objc private func emotionButtonTapped(_ sender: UIButton) {
        guard let emotion = EmotionType.allCases.first(where: { $0.hashValue == sender.tag }) else { return }
        viewModel.updateSelectedEmotion(to: emotion)
    }
}

extension EmotionViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.detailEmotions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCell.identifier, for: indexPath) as? EmotionCell else {
            return UICollectionViewCell()
        }
        
        let emotion = viewModel.detailEmotions[indexPath.item]
        cell.button.tag = indexPath.item
        cell.configure(with: emotion, emotionType: viewModel.selectedEmotion)
        
        if viewModel.selectedEmotionList.contains(emotion) {
            cell.button.backgroundColor = viewModel.selectedEmotion.color
            cell.button.setTitleColor(UIColor.coolgray900, for: .normal)
            cell.button.layer.borderWidth = 0
            cell.button.layer.cornerRadius = 6
        } else {
            cell.button.backgroundColor = .clear
            cell.button.layer.borderWidth = 1
            cell.button.layer.cornerRadius = 6
            cell.button.layer.borderColor = UIColor.coolgray200.cgColor
        }
        
        cell.button.addTarget(self, action: #selector(tappedEmotionButtons(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func tappedEmotionButtons(_ sender: UIButton) {
        guard let emotion = sender.titleLabel?.text else { return }
        viewModel.updateEmotionsList(to: emotion)
        collectionView.reloadData()
    }
}
