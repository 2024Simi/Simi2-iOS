//
//  LottieAnimationView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/12/12.
//  Copyright © 2024 inner-dev. All rights reserved.
//

//import UIKit
//import Lottie
//
//public class LottieAnimationView_2: UIView {
//    private var animationView: LottieAnimationView!
//
//    public init(animationName: String, loopMode: LottieLoopMode = .playOnce) {
//        super.init(frame: .zero)
//        setupAnimationView(animationName: animationName, loopMode: loopMode)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupAnimationView(animationName: String, loopMode: LottieLoopMode) {
//        animationView = LottieAnimationView(animationName: animationName, loopMode: loopMode)
//        animationView.contentMode = .scaleAspectFit
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(animationView)
//
//        NSLayoutConstraint.activate([
//            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            animationView.topAnchor.constraint(equalTo: topAnchor),
//            animationView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    public func play() {
//        animationView.play()
//    }
//
//    public func stop() {
//        animationView.stop()
//    }
//}
