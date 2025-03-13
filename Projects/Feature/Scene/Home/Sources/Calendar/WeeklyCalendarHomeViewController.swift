//
//  WeeklyCalendarHomeViewController.swift
//  Home
//
//  Created by cha_nyeong on 2025/03/04.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

public class WeeklyCalendarHomeViewController: UIViewController {
    private var hostingController: UIHostingController<WeeklyCalendarView>!
    private var calendarHeightConstraint: NSLayoutConstraint!
    
    private var mainEmotionComponent = MainEmotionViewComponent()
    private var aboutRecordComponent = HomeRecordViewComponent()
    private let viewModel = WeeklyCalendarViewModel()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .backgroundColor
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .backgroundColor
        return stackView
    }()
    
    let containView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCalendarView()
        setupNotificationObserver()
        setupComponent()
        bindingData()
    }

    private func setupCalendarView() {
        hostingController = UIHostingController(rootView: WeeklyCalendarView(viewModel: viewModel))
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        calendarHeightConstraint = hostingController.view.heightAnchor.constraint(equalToConstant: 150) // Weekly view is shorter
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            calendarHeightConstraint
        ])
    }

    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCalendarHeight), name: .calendarWeekChanged, object: nil)
    }

    @objc private func updateCalendarHeight() {
        self.view.layoutIfNeeded()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension WeeklyCalendarHomeViewController {
    private func setupComponent() {
        mainEmotionComponent.translatesAutoresizingMaskIntoConstraints = false
        aboutRecordComponent.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(mainEmotionComponent)
        containerStackView.addArrangedSubview(aboutRecordComponent)
        
        containView.addSubview(dateLabel)
        containView.addSubview(containerStackView)
        view.addSubview(containView)
        
        NSLayoutConstraint.activate([
            containView.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            containView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: containView.topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: containView.trailingAnchor, constant: -16),
            
            containerStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            containerStackView.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: containView.trailingAnchor, constant: -16),
            containerStackView.heightAnchor.constraint(equalToConstant: 219)
        ])
    }
}

extension WeeklyCalendarHomeViewController {
    func bindingData() {
        dateLabel.text = "\(viewModel.formattedDate())일 감정기록"
        
        mainEmotionComponent.updateData(emotion: "없어요", characterImage: .icSad, buttonTitle: "감정 기록하기", todayColor: .sad)
    }
}