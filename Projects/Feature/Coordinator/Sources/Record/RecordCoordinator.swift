//
//  RecordCoordinator.swift
//  AppCoordinator
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Record

public class RecordCoordinator {
    private let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        firstView()
    }
    
    private func firstView() {
        let viewModel = EventViewModel(diaryRecord: .event)
        let viewController = EventViewController(viewModel: viewModel)
        
        print("1 \(self.navigationController.viewControllers)")

        viewModel.nextButton = { [weak self] text in
            self?.secondView(text: text)
        }
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func secondView(text: String) {
        let viewModel = ThinkViewModel(diaryRecord: .think)
        let viewController = ThinkViewController(viewModel: viewModel)
        print("2 \(self.navigationController.viewControllers)")
        viewModel.nextButton = { [weak self] text in
            self?.thirdView(text: text)
        }
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func thirdView(text: String) {
        let viewModel = BehaviorViewModel(diaryRecord: .behavior)
        let viewController = BehaviorViewController(viewModel: viewModel)
        print("3 \(self.navigationController.viewControllers)")
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
