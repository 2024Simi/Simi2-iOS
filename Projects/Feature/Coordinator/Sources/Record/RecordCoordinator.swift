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
        let viewModel = RecordViewModel(diaryRecord: .event)
        let viewController = RecordViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
