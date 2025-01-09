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
import Record

public class HomeCoordinator {
    private let navigationController: UINavigationController
    private var recordCoordinator: RecordCoordinator
    
    public init(
        navigationController: UINavigationController,
        recordCoordinator: RecordCoordinator
    ) {
        self.navigationController = navigationController
        self.recordCoordinator = recordCoordinator
    }
    
    public func start() {
        firstView()
    }
    
    private func firstView() {
        let viewController = CalendarHomeViewController()
        viewController.mainEmotionComponent.buttonTapped = { [weak self] diaryDetailDTO in
            self?.startRecordCoordinator(with: diaryDetailDTO)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startRecordCoordinator(with diaryId: Int?) {
        let recordCoordinator = RecordCoordinator(navigationController: navigationController)
        self.recordCoordinator = recordCoordinator
        recordCoordinator.delegate = self
        recordCoordinator.diaryId = diaryId
        recordCoordinator.start()
    }
}

extension HomeCoordinator: RecordCoordinatorDelegate {
    public func navigateBackToHome() {
        navigationController.popToRootViewController(animated: true)
    }
}
