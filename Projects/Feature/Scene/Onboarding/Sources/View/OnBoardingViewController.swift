//
//  OnBoardingViewController.swift
//  Home
//
//  Created by cha_nyeong on 11/15/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Common
import DesignSystem

public final class OnBoardingViewController: BaseViewController<OnBoardingViewModel> {
    // MARK: - Properties
    public var didTapAppleLogin: (() -> Void)?
    public var didTapKakaoLogin: (() -> Void)?
    
    // MARK: - Views
    private let lottieAnimationView: LottieAnimationWrapper = {
        let animationView = LottieAnimationWrapper(animationName: "onBoardingSimi", loopMode: .loop) // Lottie 파일 이름
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마음다이어리"
        label.textAlignment = .center
        label.font = FontCase.bold(.title1).toUIFont
        label.textColor = .coolgray900
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "시미에게 진심을 전하고 공감얻기"
        label.textAlignment = .center
        label.font = FontCase.semibold(.body).toUIFont
        label.textColor = .gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "AI가 당신의 이야기를 듣고 답해주는, 나만의 깊은 공간"
        label.textAlignment = .center
        label.font = FontCase.semibold(.footnote).toUIFont
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var appleLoginButton: LoginButtonView = {
        let button = LoginButtonView(
            image: .icApple,
            title: "애플로 시작하기",
            backgroundColor: .coolgray900,
            titleColor: .white
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var kakaoLoginButton: LoginButtonView = {
        let button = LoginButtonView(
            image: .icKakao,
            title: "카카오 로그인",
            backgroundColor: .kakao,
            titleColor: .coolgray900
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: LifeCycle Method
    public override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
    }
    
    //MARK: Bind
    public override func bind() {
        super.bind()
    }
    
    //MARK: AutoLayout
    public override func setAutoLayout() {
        super.setAutoLayout()
        
        view.addSubviews(lottieAnimationView,titleLabel,subtitleLabel, noticeLabel,appleLoginButton,kakaoLoginButton)
        
        // 버튼에 탭 액션 추가
        appleLoginButton.setTapAction { [weak self] in
            self?.didTapAppleLogin?()
        }
        
        kakaoLoginButton.setTapAction { [weak self] in
            self?.didTapKakaoLogin?()
        }
        
        NSLayoutConstraint.activate([
            lottieAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieAnimationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            lottieAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            lottieAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            lottieAnimationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            lottieAnimationView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: lottieAnimationView.bottomAnchor),
            
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            
            noticeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noticeLabel.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -12),
            
            appleLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            appleLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            appleLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: -8),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 48),
            
            kakaoLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            kakaoLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            kakaoLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            kakaoLoginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        view.backgroundColor = .pureWhite
    }
}
