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
        setupBindings()
        setupNavigationBar()
        setupUI()
        setupBottomButtons()
        setupConstraints()
        addGesture()
    }
    
    private let caseLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.footnote))
        label.textColor = .pureBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: label.font.lineHeight).isActive = true
        return label
    }()
        
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.bold(.title2))
        label.textColor = .coolgray900
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: label.font.lineHeight).isActive = true
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
        label.heightAnchor.constraint(equalToConstant: label.font.lineHeight).isActive = true
        label.textAlignment = .center
        return label
    }()
    
    /// 감정 대분류를 위한 stackView
    private let emotionTypeButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true // 여백 활성화
        return stack
    }()
    
    /// 대분류 + collectionview를 위한 stackView
    private let emotionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// 다음에 쓸래요 + 완료를 위한 stackView
    private let bottomButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    /// emotionStackView + bottomButtonStackView
    private let sheetViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.05
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

// MARK: - Gesture 관련 Extension
extension EmotionViewController {
    func addGesture() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipeGesture.direction = .left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipeGesture.direction = .right
        
        // 제스처를 뷰에 추가
        sheetView.addGestureRecognizer(leftSwipeGesture)
        sheetView.addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            viewModel.updateSelectedEmotionByGesture(viewModel.selectedEmotion, .left)
            updateButtonState()
            updateButtonColors()
            collectionView.reloadData()
        case .right:
            viewModel.updateSelectedEmotionByGesture(viewModel.selectedEmotion, .right)
            updateButtonState()
            updateButtonColors()
            collectionView.reloadData()
        default:
            break
        }
    }
}

// MARK: - Action 관련 Extension
extension EmotionViewController {
    @objc private func tappedEmotionButtons(_ sender: UIButton) {
        guard let emotion = sender.titleLabel?.text else { return }
        viewModel.updateEmotionsList(to: emotion)
        collectionView.reloadData()
        updateButtonState()
    }
    
    private func updateButtonState() {
        if viewModel.selectedEmotionList.count <= 5, !viewModel.selectedEmotionList.isEmpty {
            nextButton.isDisabled = false
        } else {
            nextButton.isDisabled = true
        }
    }
    
    private func setupBottomButtons() {
        cancelButton.tap {
            print("cancel button tapped")
        }
        
        nextButton.tap {
            print("next button tapped")
        }
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
            button.setTitleColor((viewModel.selectedEmotion == emotion ? UIColor.coolgray800 : UIColor.coolgray500), for: .normal)
        }
    }
    
    @objc private func emotionButtonTapped(_ sender: UIButton) {
        print("sender \(sender.tag)")
        guard let emotion = EmotionType.allCases.first(where: { $0.hashValue == sender.tag }) else { return }
        viewModel.updateSelectedEmotion(to: emotion)
    }
}

// MARK: - layout 관련 Extension
extension EmotionViewController {
    private func setupConstraints() {

        view.addSubview(caseLabel)
        view.addSubview(questionLabel)
        view.addSubview(characterImage)
        view.addSubview(assistanceLabel)
        view.addSubview(sheetView)
        sheetView.addSubview(sheetViewStack)
        
        emotionStackView.addArrangedSubview(emotionTypeButtonStack)
        emotionStackView.addArrangedSubview(collectionView)
        bottomButtonStackView.addArrangedSubview(cancelButton)
        bottomButtonStackView.addArrangedSubview(nextButton)
        sheetViewStack.addArrangedSubview(emotionStackView)
        sheetViewStack.addArrangedSubview(bottomButtonStackView)
        
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
            
            assistanceLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 0),
            assistanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            assistanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 228),
            
            sheetView.topAnchor.constraint(equalTo: assistanceLabel.bottomAnchor, constant: 28),
            sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            sheetViewStack.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 24),
            sheetViewStack.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 16),
            sheetViewStack.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -16),
            sheetViewStack.bottomAnchor.constraint(equalTo: sheetView.bottomAnchor, constant: -32)
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
        for emotion in EmotionType.allCases {
            let button = UIButton(type: .system)
            let buttonWidth = (view.bounds.width - 42) / 5
            button.tag = emotion.hashValue
            button.setTitle(emotion.rawValue, for: .normal)
            button.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
            button.setTitleColor((viewModel.selectedEmotion == emotion ? UIColor.coolgray800 : UIColor.coolgray500), for: .normal)
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
        let wordWidth = (view.bounds.width - 56) / 3 //56
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12 // 12
        layout.itemSize = CGSize(width: wordWidth, height: 40)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: EmotionCell.identifier)
        collectionView.dataSource = self
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
}
