//
//  HomeCoordinator.swift
//  AppCoordinator
//
//  Created by 박서연 on 2024/12/10.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Models
import Home

public class HomeCoordinator {
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        firstView()
    }
    
    private func firstView() {
        let viewController = CalendarHomeViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
