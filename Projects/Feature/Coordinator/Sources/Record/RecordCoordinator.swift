//
//  RecordCoordinator.swift
//  AppCoordinator
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Record
import Models

public protocol RecordCoordinatorDelegate: AnyObject {
    func navigateBackToHome()
}

/// 기록화면을 위한 Coordinator
public class RecordCoordinator {
    private let navigationController: UINavigationController

    public var diaryId: Int?
    public weak var delegate: RecordCoordinatorDelegate?
    
    public init(
        navigationController: UINavigationController,
        diaryId: Int?
    ) {
        self.navigationController = navigationController
        self.diaryId = diaryId
    }
    
    public func start() {
        if let diary = diaryId {
            fifthView(diaryID: diary)
        } else {
            firstView()
        }
    }
    
    private func firstView() {
        let viewModel = EventViewModel(diaryRecord: .event)
        let viewController = EventViewController(viewModel: viewModel)

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
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        viewModel.nextButton = { [weak self] text in
            self?.fourthView()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func fourthView() {
        let viewModel = EmotionViewModel(diaryRecord: .emotions)
        let viewController = EmotionViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        viewModel.nextButton = { [weak self] text in
            self?.fifthView(diaryID: 0)
        }
    }
    
    private func fifthView(diaryID: Int) {
        let viewModel = ResultViewModel(diaryId: diaryID)
        let viewController = ResultViewController(viewModel: viewModel)
        
        viewModel.backButton = {
            self.delegate?.navigateBackToHome()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
