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

        viewModel.nextButton = { [weak self] text in
            self?.secondView(text: text)
        }
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
        
//        let viewModel = ResultViewModel(diaryEntity: DiaryEntity(event: "event", behavior: "behavior", think: "think", emotions: ["감동적인","감사한","자신있는","우려스러운","조마조마한"]), diaryString: DiaryString(eventString: "eventString", behaviorString: "behaviorString", thinkString: "thinkString"))
//        
//        let viewController = ResultViewController(viewModel: viewModel)
//        navigationController.pushViewController(viewController, animated: true)
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
            self?.fifthView()
        }
    }
    
    private func fifthView() {
        let viewModel = ResultViewModel(
            diaryEntity: DiaryEntity(
                event: "event",
                behavior: "behavior",
                think: "think",
                emotions: ["감동적인","감사한","자신있는","우려스러운","조마조마한"]
            ),
            diaryString: DiaryString(
                eventString: "eventString",
                behaviorString: "behaviorString",
                thinkString: "thinkString"
            )
        )
        let viewController = ResultViewController(viewModel: viewModel)
        
        viewModel.backButton = {
            self.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
