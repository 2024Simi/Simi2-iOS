//
//  OnboardingCoordinator.swift
//  AppCoordinator
//
//  Created by cha_nyeong on 11/16/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Common
import Onboarding

public protocol OnboardingCoordinatorDelegate: AnyObject {
    func didFinishOnboarding()
}

public final class OnboardingCoordinator {
    
    // MARK: - Properties
    public var childCoordinators: [Any] = []
    public var navigationController: UINavigationController
    public weak var delegate: OnboardingCoordinatorDelegate?
    
    // MARK: - Init
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    public func start() {
        showOnboardingScreen()
    }
    
    // MARK: - Private methods
    private func showOnboardingScreen() {
        let viewModel = OnBoardingViewModel()
        let viewController = OnBoardingViewController(viewModel: viewModel)
        
        viewController.didTapAppleLogin = { [weak self] in
            self?.showAgreementScreen()
        }
        
        viewController.didTapKakaoLogin = { [weak self] in
            self?.showAgreementScreen()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showAgreementScreen() {
        let viewModel = AgreementViewModel()
        let viewController = AgreementViewController(viewModel: viewModel)
        
        viewController.didTapNextButton = { [weak self] in
            self?.showNicknameScreen()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showNicknameScreen() {
        let viewModel = NicknameViewModel()
        let viewController = NicknameViewController(viewModel: viewModel)
        
        viewController.didTapConfirmButton = { [weak self] in
            self?.showNotiSettingScreen()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showNotiSettingScreen() {
        let viewModel = NotiSettingViewModel()
        let viewController = NotiSettingViewController(viewModel: viewModel)
        
        viewController.didTapStartButton = { [weak self] in
            self?.showStartAnimationScreen()
        }
        
        viewController.didTapLaterButton = { [weak self] in
            self?.finishOnboarding()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showStartAnimationScreen() {
        let viewController = StartAnimationViewController()
        
        viewController.didFinishAnimation = { [weak self] in
            self?.finishOnboarding()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func finishOnboarding() {
        delegate?.didFinishOnboarding()
    }
}
