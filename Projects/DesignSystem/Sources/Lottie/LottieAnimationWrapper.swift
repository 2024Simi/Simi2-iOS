//
//  LottieAnimationWrapper.swift
//  DesignSystem
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import Lottie

public class LottieAnimationWrapper: UIView {
    private var animationView: LottieAnimationView!

    public init(animationName: String, loopMode: LottieLoopMode = .playOnce) {
        super.init(frame: .zero)
        setupAnimationView(animationName: animationName, loopMode: loopMode)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAnimationView(animationName: String, loopMode: LottieLoopMode) {
        // Lottie의 AnimationView 초기화
        animationView = LottieAnimationView.init(name: animationName)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFill // 화면을 꽉 채우도록 설정
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func play(completion: LottieCompletionBlock? = nil) {
        animationView.play(completion: completion)
    }

    public func stop() {
        animationView.stop()
    }
}
