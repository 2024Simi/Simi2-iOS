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

    private let calendarView = CustomCalendarView()
    private var hostingController: UIHostingController<CustomCalendarView>!
    let emotionComponent = MainEmotionViewComponent()
    let noneRecordComponent = PastNoneRecordComponentView()
    let recordHeartComponent = HomeRecordViewComponent()
    
    private let componentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.12.10일 감정기록"
        label.applyFontCase(.semibold(.footnote))
        label.textColor = .gray700
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        // SwiftUI 뷰 설정
        hostingController = UIHostingController(rootView: calendarView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        hostingController.view.backgroundColor = .white
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        setupComponent()
        
        print("hostingController.view.frame.height \(hostingController.view.frame.height)")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("💥hostingController.view.frame.height: \(hostingController.view.frame.height)")
    }

    
    private func setupComponent() {
        // UIStackView에 UIKit 컴포넌트 추가
        componentStackView.addArrangedSubview(emotionComponent)
        componentStackView.addArrangedSubview(recordHeartComponent)
        
        // UIView에 추가
        view.addSubview(dateLabel)
        view.addSubview(componentStackView)
        
        // 레이아웃 설정
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            componentStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            componentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            componentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            componentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}
