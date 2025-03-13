//
//  StartAnimationViewController.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import Lottie
import DesignSystem

public class StartAnimationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var lottieAnimationWrapper: LottieAnimationWrapper?
    
    // MARK: - Lifecycle
    
    public var didFinishAnimation: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAnimationView() // 애니메이션 뷰를 먼저 설정하여 라벨이 위에 그려지게 함
        setupLabels()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Start the animation after 300ms
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            // 라벨 페이드 아웃 애니메이션 추가
            UIView.animate(withDuration: 0.3) {
                self?.subtitleLabel.alpha = 0
                self?.titleLabel.alpha = 0
            }
            
            // 애니메이션 재생
            self?.lottieAnimationWrapper?.play { completed in
                if completed {
                    // Wait for 300ms after animation completes then navigate to home
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self?.navigateToHomeScreen()
                    }
                }
            }
        }
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupLabels() {
        // Setup subtitle label (시미를)
        subtitleLabel.text = "시미를"
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        // Setup title label (시작해볼게요)
        titleLabel.text = "시작해볼게요"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // SafeArea를 사용하지 않고 직접 위치 설정하여 더 적극적인 레이아웃
        // 화면 상단에서부터의 값을 계산하여 배치
        let topSpacing: CGFloat = 140  // 상단에서 더 가까운 위치에 배치
        
        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpacing), // SafeArea 대신 view의 top 사용
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupAnimationView() {
        // LottieAnimationWrapper 초기화 및 설정
        lottieAnimationWrapper = LottieAnimationWrapper(animationName: "simi2", loopMode: .playOnce)
        guard let lottieAnimationWrapper = lottieAnimationWrapper else { return }
        
        lottieAnimationWrapper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationWrapper)
        
        // SafeArea 제약 조건 대신 view의 edge를 기준으로 설정
        NSLayoutConstraint.activate([
            lottieAnimationWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lottieAnimationWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lottieAnimationWrapper.topAnchor.constraint(equalTo: view.topAnchor),
            lottieAnimationWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    
    private func navigateToHomeScreen() {
           // Coordinator를 통해 화면 전환
           didFinishAnimation?()
       }
}
