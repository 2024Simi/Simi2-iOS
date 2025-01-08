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
    
    func startRecordCoordinator(with diaryDetail: DiaryDetailDTO?) {
        let recordCoordinator = RecordCoordinator(navigationController: navigationController, diaryDetail: diaryDetail)
        recordCoordinator.delegate = self
        self.recordCoordinator = recordCoordinator
        recordCoordinator.start()
    }
}

extension HomeCoordinator: RecordCoordinatorDelegate {
    public func navigateBackToHome() {
        let homeViewController = CalendarHomeViewController()
        homeViewController.mainEmotionComponent.buttonTapped = { [weak self] diaryDetail in
            self?.startRecordCoordinator(with: diaryDetail)
        }
        navigationController.setViewControllers([homeViewController], animated: true)
    }
}
