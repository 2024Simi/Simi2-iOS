//
//  NicknameViewController.swift
//  Home
//
//  Created by cha_nyeong on 11/19/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem
import Common

public final class NicknameViewController: BaseViewController<NicknameViewModel> {
    
    //MARK: Properties
    public var didTapConfirmButton: (() -> Void)?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SYM에서 사용할\n닉네임을 입력해주세요"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = FontCase.bold(.title3).toUIFont
        label.textColor = .coolgray900
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let simiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgSimis
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nicknameView: FloatingLabelTextField = {
        let nicknameView = FloatingLabelTextField()
        nicknameView.placeholderText = "최소 2~12자 이내의 닉네임을 설정해주세요"
        nicknameView.translatesAutoresizingMaskIntoConstraints = false
        return nicknameView
    }()
    
    // 상태 메시지 라벨 추가
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = FontCase.regular(.caption1).toUIFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인하기", for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    
    // MARK: LifeCycle Method
    public override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        setupTextField()
    }
    
    //MARK: AutoLayout
    public override func setAutoLayout() {
        super.setAutoLayout()
        
        view.addSubview(titleLabel)
        view.addSubview(simiImageView)
        view.addSubview(nicknameView)
        view.addSubview(statusLabel)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Simi Image
            simiImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            simiImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            simiImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Nickname View
            nicknameView.topAnchor.constraint(equalTo: simiImageView.bottomAnchor, constant: 40),
            nicknameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nicknameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nicknameView.heightAnchor.constraint(equalToConstant: 70),
            
            statusLabel.topAnchor.constraint(equalTo: nicknameView.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: nicknameView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: nicknameView.trailingAnchor),
            
            
            // Confirm Button
            confirmButton.topAnchor.constraint(equalTo: nicknameView.bottomAnchor, constant: 40),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.backgroundColor = .pureWhite
    }
    
    private func setupTextField() {
        // 키보드 설정
        nicknameView.setKeyboardType(.default)
        nicknameView.setReturnKeyType(.done)
        nicknameView.setAutocorrectionType(.no)
        nicknameView.setAutocapitalizationType(.none)
        
        // 닉네임 검증 콜백 설정
        nicknameView.checkNicknameStatus = { [weak self] text in
            self?.checkNicknameAvailability(text)
        }
        
        // 텍스트 변경 이벤트 처리
        nicknameView.textDidChangeHandler = { [weak self] text in
            // 텍스트 상태에 따라 확인 버튼 활성화/비활성화
            self?.updateConfirmButtonState()
        }
        
        // 리턴 키 처리
        nicknameView.returnKeyHandler = { [weak self] in
            // 유효한 경우에만 확인 버튼 동작과 동일하게 처리
            if self?.confirmButton.isEnabled == true {
                self?.confirmButtonTapped()
            }
        }
    }
    
    // 닉네임 사용 가능 여부 확인
    private func checkNicknameAvailability(_ nickname: String) {
        // ViewModel을 통한 검증 또는 서버 통신 로직
        // 임시로 TestTextFieldViewController의 로직 사용
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            // 2-12자 범위 내면 사용 가능으로 처리
            if nickname.count >= 2 && nickname.count <= 12 {
                self?.nicknameView.nicknameStatus = .available
                self?.updateStatusLabel(isAvailable: true)
            } else {
                self?.nicknameView.nicknameStatus = .unavailable
                self?.updateStatusLabel(isAvailable: false)
            }
            
            self?.updateConfirmButtonState()
        }
    }
    
    private func updateStatusLabel(isAvailable: Bool) {
        statusLabel.isHidden = false
        
        if isAvailable {
            statusLabel.text = "사용 가능한 닉네임이에요"
            statusLabel.textColor = .green
        } else {
            statusLabel.text = "2~12자의 닉네임만 사용 가능해요"
            statusLabel.textColor = .red
        }
    }
    
    private func updateConfirmButtonState() {
        // 닉네임 상태가 available일 때만 버튼 활성화
        let isEnabled = nicknameView.nicknameStatus == .available
        
        // 버튼 활성화 여부 및 스타일 변경
        confirmButton.isEnabled = isEnabled
        confirmButton.backgroundColor = isEnabled ? .coolgray800 : .coolgray300
    }
    
    //MARK: Bind
    public override func bind() {
        super.bind()
        
        // ViewModel과의 바인딩 로직 추가
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmButtonTapped() {
        // 닉네임 설정 완료 처리
        guard let nickname = nicknameView.text, !nickname.isEmpty else { return }
        
        // ViewModel을 통한 닉네임 저장 로직 추가
        // viewModel.setNickname(nickname)
        
        // 다음 화면으로 이동
        didTapConfirmButton?()
    }
}
