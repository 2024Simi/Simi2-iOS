//
//  AgreementViewController.swift
//  Home
//
//  Created by cha_nyeong on 11/17/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Common
import Combine

public final class AgreementViewController: BaseViewController<AgreementViewModel> {
    
    //MARK: Properties
    private var cancellables = Set<AnyCancellable>()
    public var didTapNextButton: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약관에 동의해 주세요"
        label.textColor = .coolgray900
        label.font = FontCase.bold(.title3).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여러분의 개인정보와 서비스 이용 관리\n잘 지켜드릴게요"
        label.numberOfLines = 0
        label.textColor = .coolgray500
        label.font = FontCase.regular(.subheadline).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let allAgreeContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allAgreeCheckBox: CheckBox = {
        let checkBox = CheckBox(frame: .zero)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    private let allAgreeTitle: UILabel = {
        let label = UILabel()
        label.text = "전체동의"
        label.textColor = .coolgray800
        label.font = FontCase.bold(.body).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let allAgreeDescription: UILabel = {
        let label = UILabel()
        label.text = "서비스 이용을 위해 아래 약관에 모두 동의합니다."
        label.textColor = .coolgray500
        label.font = FontCase.regular(.footnote).toUIFont
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let termsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let serviceCheckBox = CheckBox(frame: .zero)
    private let privacyCheckBox = CheckBox(frame: .zero)
    private let marketingCheckBox = CheckBox(frame: .zero)
    
    private lazy var serviceTermsView = createTermRow(checkbox: serviceCheckBox, title: "(필수) 서비스 이용약관 동의")
    private lazy var privacyTermsView = createTermRow(checkbox: privacyCheckBox, title: "(필수) 개인정보 수집 및 이용동의")
    private lazy var marketingTermsView = createTermRow(checkbox: marketingCheckBox, title: "(선택) 마케팅 수신 동의")
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음으로", for: .normal)
        button.titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
        button.backgroundColor = .coolgray300
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func buttonTap() {
        
    }
    
    
    //MARK: AutoLayout
    public override func setAutoLayout() {
        super.setAutoLayout()
        
        view.backgroundColor = .white
        
        // Navigation Bar Setup
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        // Add subviews
        allAgreeContainerView.addSubviews(allAgreeCheckBox,allAgreeTitle,allAgreeDescription)
        
        view.addSubviews(titleLabel,subtitleLabel,nextButton,allAgreeContainerView,termsStackView)
        
        [serviceTermsView, privacyTermsView, marketingTermsView].forEach {
            termsStackView.addArrangedSubview($0)
        }
        
        // AutoLayout
        NSLayoutConstraint.activate([
            allAgreeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            allAgreeContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            allAgreeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            allAgreeContainerView.heightAnchor.constraint(equalToConstant: 40),
            
            allAgreeTitle.topAnchor.constraint(equalTo: allAgreeContainerView.topAnchor),
            allAgreeTitle.leadingAnchor.constraint(equalTo: allAgreeCheckBox.trailingAnchor, constant: 12),
            allAgreeTitle.trailingAnchor.constraint(equalTo: allAgreeContainerView.trailingAnchor),
            
            allAgreeDescription.topAnchor.constraint(equalTo: allAgreeTitle.bottomAnchor, constant: 4),
            allAgreeDescription.leadingAnchor.constraint(equalTo: allAgreeCheckBox.trailingAnchor, constant: 12),
            allAgreeDescription.trailingAnchor.constraint(equalTo: allAgreeContainerView.trailingAnchor),
            
            allAgreeCheckBox.leadingAnchor.constraint(equalTo: allAgreeContainerView.leadingAnchor),
            allAgreeCheckBox.centerYAnchor.constraint(equalTo: allAgreeContainerView.centerYAnchor),
            allAgreeCheckBox.widthAnchor.constraint(equalToConstant: 24),
            allAgreeCheckBox.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            
            termsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            termsStackView.topAnchor.constraint(equalTo: allAgreeContainerView.bottomAnchor, constant: 28),
            termsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //약관 생성 함수
    private func createTermRow(checkbox: CheckBox, title: String) -> UIView {
        let container = UIView()
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = title
            label.textColor = .coolgray800
            label.font = FontCase.regular(.subheadline).toUIFont
            return label
        }()
        let detailButton: UIButton = {
            let detailButton = UIButton()
            detailButton.setTitle("보기", for: .normal)
            detailButton.titleLabel?.font = FontCase.semibold(.footnote).toUIFont
            detailButton.setTitleColor(.coolgray400, for: .normal)
            return detailButton
        }()
        
        [checkbox, titleLabel, detailButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 24),
            checkbox.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            detailButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            detailButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            container.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return container
    }
    
    // MARK: LifeCycle Method
    public override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func nextButtonTapped() {
        didTapNextButton?()
    }
    
    //MARK: Bind
    public override func bind() {
        super.bind()
        
        allAgreeCheckBox.checkBoxTapped = { [weak self] in
            self?.viewModel.toggleAllAgree()
        }
        
        // 개별 체크박스 바인딩
        serviceCheckBox.checkBoxTapped = { [weak self] in
            self?.viewModel.serviceChecked.toggle()
        }
        
        privacyCheckBox.checkBoxTapped = { [weak self] in
            self?.viewModel.privacyChecked.toggle()
        }
        
        marketingCheckBox.checkBoxTapped = { [weak self] in
            self?.viewModel.marketingChecked.toggle()
        }
        
        // UI 상태 업데이트 바인딩
        viewModel.$allAgreeChecked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChecked in
                self?.allAgreeCheckBox.isChecked = isChecked
            }
            .store(in: &cancellables)
            
        viewModel.$serviceChecked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChecked in
                self?.serviceCheckBox.isChecked = isChecked
            }
            .store(in: &cancellables)
            
        viewModel.$privacyChecked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChecked in
                self?.privacyCheckBox.isChecked = isChecked
            }
            .store(in: &cancellables)
            
        viewModel.$marketingChecked
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isChecked in
                self?.marketingCheckBox.isChecked = isChecked
            }
            .store(in: &cancellables)
            
        // 다음 버튼 상태 바인딩
        viewModel.$isNextButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.nextButton.isEnabled = isEnabled
                self?.nextButton.backgroundColor = isEnabled ? .coolgray700 : .coolgray300
            }
            .store(in: &cancellables)
    }
        
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
