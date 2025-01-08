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
    private var aboutRecordComponent = HomeRecordViewComponent()
    private let viewModel = CustomCalendarViewModel()
    public var mainEmotionComponent = MainEmotionViewComponent()
    public var pastNoneRecord = PastNoneRecordComponentView()
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateCalendarUnderTitle), name: .calenderUnderTitleChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateIspateConstraints), name: .calendarIspateChanged, object: nil)
    }
    
    @objc private func updateCalendarHeight() {
        self.calendarHeightConstraint.constant = self.calculateNewHeight()
        self.view.layoutIfNeeded()
    }
    
    @objc private func updateCalendarUnderTitle() {
        bindingData()
    }
    
    @objc private func updateIspateConstraints() {
        setupComponent()
    }

    private func calculateNewHeight() -> CGFloat {
        return hostingController.rootView.viewModel.numberOfWeeks(in: hostingController.rootView.viewModel.currentMonth) == 35 ? 386 : 442
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bindingData()
        setupComponent()
    }
}

extension CalendarHomeViewController {
    private func setupComponent() {
        if viewModel.isPaste {
            setupPastComponent()
        } else {
            setupTodayComponent()
        }
    }
    
    private func setupTodayComponent() {
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
    
    private func setupPastComponent() {
        pastNoneRecord.translatesAutoresizingMaskIntoConstraints = false
        
        containView.addSubview(dateLabel)
        containView.addSubview(pastNoneRecord)
        view.addSubview(containView)
        
        NSLayoutConstraint.activate([
            containView.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            containView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: containView.topAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: containView.trailingAnchor, constant: -16),
            
            pastNoneRecord.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            pastNoneRecord.leadingAnchor.constraint(equalTo: containView.leadingAnchor, constant: 16),
            pastNoneRecord.trailingAnchor.constraint(equalTo: containView.trailingAnchor, constant: -16),
            pastNoneRecord.heightAnchor.constraint(equalToConstant: 219)
        ])
    }
}

extension CalendarHomeViewController {
    func bindingData() {
        dateLabel.text = "\(viewModel.underDateTitle)일 감정기록"
        mainEmotionComponent.updateData(emotion: viewModel.emotionLabel, characterImage: viewModel.characterImage, buttonTitle: DiaryLabel.recordLabel, todayColor: viewModel.emotionColor)
        aboutRecordComponent.updateData(recordColor: viewModel.recordColor, subLabel: viewModel.recordSubLabel, mainLabel: viewModel.recordMainLabel, heart: viewModel.heartImage)
        
    }
}
