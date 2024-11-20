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
    private var collectionView: UICollectionView!
    private let viewModel = EmotionViewModel()
    private var tappedEmotinoType: EmotionType = .happy
    private var emotionButtons: [UIButton] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    
}

// MARK: - setup UI
extension EmotionViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 0
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
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
            buttonStack.addArrangedSubview(button)
            emotionButtons.append(button)
        }
        
        let layout = UICollectionViewFlowLayout()
        let wordWidth = (view.bounds.width - 56) / 3
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: wordWidth, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: EmotionCell.identifier)
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.updateButtonColors() // 버튼 색상 업데이트
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
        
        
//        cell.button.setTitle(emotion, for: .normal)
//        cell.button.backgroundColor = viewModel.selectedEmotion.color
//        cell.button.setTitleColor(.blue, for: .normal)
//        print("viewModel.detailEmotions \(emotion)")
//
        let emotion = viewModel.detailEmotions[indexPath.item]
        cell.button.tag = indexPath.item
        cell.configure(with: emotion, emotionType: viewModel.selectedEmotion)
        cell.button.addTarget(self, action: #selector(tappedEmotionButtons), for: .touchUpInside)
        return cell
    }
    
    @objc private func tappedEmotionButtons() {
        viewModel.onEmotionsListUpdated = {
//            viewModel.selectedEmotionList.appe
        }
    }
}


//public class EmotionsViewController: UIViewController {
//    
//    public let viewModel: EmotionsViewModel
//    public var customBar: CustomNavigationBar
//    
//    public init(
//        viewModel: EmotionsViewModel,
//        customBar: CustomNavigationBar = CustomNavigationBar()
//    ) {
//        self.viewModel = viewModel
//        self.customBar = customBar
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupCollectionView()
//    }
//    
//    private let caseLabel: UILabel = {
//        let label = UILabel()
//        label.applyFontCase(.bold(.footnote))
//        label.textColor = .pureBlack
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let questionLabel: UILabel = {
//        let label = UILabel()
//        label.applyFontCase(.bold(.title2))
//        label.textColor = .coolgray900
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let nextButton: CommonButton = {
//        let button = CommonButton()
//        button.text = "다음으로"
//        button.isDisabled = true
//        return button
//    }()
//    
//    private let cancelButton: CancelButton = {
//        let button = CancelButton()
//        button.text = "다음에 할래요"
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let buttonStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 12
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private let gridStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 100
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//    private let characterImage: UIImageView = {
//        let image = UIImageView()
//        image.image = .icSample
//        image.contentMode = .scaleAspectFit
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//    
//    private let assistanceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .coolgray600
//        label.font = FontCase.semibold(.footnote).toUIFont
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        return label
//    }()
//    
//    // MARK: - 감정 단어 선택
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
//        layout.scrollDirection = .vertical
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: "EmotionCell")
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//}
//
//extension EmotionsViewController {
//    private func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    
//    private func setupConstraints() {
//        view.addSubview(customBar)
//        view.addSubview(caseLabel)
//        view.addSubview(questionLabel)
//        view.addSubview(characterImage)
//        view.addSubview(assistanceLabel)
//        view.addSubview(collectionView)
//        
//        NSLayoutConstraint.activate([
//            customBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            customBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            customBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            caseLabel.topAnchor.constraint(equalTo: customBar.bottomAnchor, constant: 16),
//            caseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            caseLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            questionLabel.topAnchor.constraint(equalTo: caseLabel.bottomAnchor, constant: 8),
//            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            characterImage.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
//            characterImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            characterImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            assistanceLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10),
//            assistanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            assistanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            collectionView.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor, constant: 100),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
//
//extension EmotionsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.choicedEmotion.detailEmotion.count
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmotionCell", for: indexPath) as! EmotionCell
//        let item = viewModel.choicedEmotion.detailEmotion[indexPath.item]
//        
//        return cell
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 56) / 3
//        return CGSize(width: width, height: 40)
//    }
//}
//
//public class EmotionCell: UICollectionViewCell {
//    private let label: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        return label
//    }()
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupCell()
//    }
//    
//    public required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupCell() {
//        contentView.backgroundColor = .white
//        contentView.layer.borderColor = UIColor.coolgray200.cgColor
//        contentView.layer.cornerRadius = 6
//        
//        contentView.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//        ])
//    }
//}
