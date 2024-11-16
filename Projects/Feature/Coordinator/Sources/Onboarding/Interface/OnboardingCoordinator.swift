//
//  OnboardingCoordinator.swift
//  AppCoordinator
//
//  Created by cha_nyeong on 11/16/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Common

public final class OnboardingCoordinator: Coordinator {
    
    public var childCoordinators: [Coordinator]
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    public func start() {
        
    }
}
