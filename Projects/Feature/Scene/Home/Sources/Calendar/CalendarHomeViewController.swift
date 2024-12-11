//
//  CalendarHomeViewController.swift
//  Home
//
//  Created by 박서연 on 2024/12/10.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

public class CalendarHomeViewController: UIViewController {
    private var hostingController: UIHostingController<CustomCalendarView>!
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    private var mainEmotionComponent = MainEmotionViewComponent()
    private var aboutRecordComponent = HomeRecordViewComponent()
    private let viewModel = CustomCalendarViewModel()
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupCalendarView()
        setupNotificationObserver()
        setupComponent()
    }

    private func setupCalendarView() {
        hostingController = UIHostingController(rootView: CustomCalendarView(viewModel: viewModel))
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        calendarHeightConstraint = hostingController.view.heightAnchor.constraint(equalToConstant: 386) 
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarHeightConstraint
        ])
    }

    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCalendarHeight), name: .calendarHeightChanged, object: nil)
    }

    @objc private func updateCalendarHeight() {
        self.calendarHeightConstraint.constant = self.calculateNewHeight()
        self.view.layoutIfNeeded()
    }

    private func calculateNewHeight() -> CGFloat {
        return hostingController.rootView.viewModel.numberOfWeeks(in: hostingController.rootView.viewModel.currentMonth) == 35 ? 386 : 442
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension CalendarHomeViewController {
    private func setupComponent() {
        mainEmotionComponent.translatesAutoresizingMaskIntoConstraints = false
        aboutRecordComponent.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addArrangedSubview(mainEmotionComponent)
        containerView.addArrangedSubview(aboutRecordComponent)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: 30),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}
