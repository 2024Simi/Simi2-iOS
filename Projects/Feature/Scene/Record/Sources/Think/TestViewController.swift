//
//  TestViewController.swift
//  Home
//
//  Created by 박서연 on 2024/11/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public class TestViewController: UIViewController {
    let customTest = CusotmAlert()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        // 버튼으로 팝업 호출 예제
        let showPopupButton = UIButton(type: .system)
        showPopupButton.setTitle("Show Popup", for: .normal)
        showPopupButton.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        
        showPopupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showPopupButton)
        
        NSLayoutConstraint.activate([
            showPopupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPopupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // 버튼으로 팝업 호출 예제
        let secondButton = UIButton(type: .system)
        secondButton.setTitle("secondButton", for: .normal)
        secondButton.addTarget(self, action: #selector(showPopupTwo), for: .touchUpInside)
        
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondButton)
        
        NSLayoutConstraint.activate([
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: showPopupButton.bottomAnchor, constant: 30)
        ])
        
        // 버튼으로 팝업 호출 예제
        let thirdButton = UIButton(type: .system)
        thirdButton.setTitle("thirdButton", for: .normal)
        thirdButton.addTarget(self, action: #selector(showPopupThird), for: .touchUpInside)
        
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(thirdButton)
        
        NSLayoutConstraint.activate([
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 30)
        ])
    }
    
    
    @objc public func showPopup() {
        PopupManager.shared.showPopup(on: self, title: "title", content: "content", LButton: "LButton", RButton: "Rbutton", type: .TitleContentDButton)
    }
    
    @objc public func showPopupTwo() {
        PopupManager.shared.showPopup(on: self, title: "title", content: "content", SButton: "확인", type: .TitleContentSButton)
    }
    
    @objc public func showPopupThird() {
        PopupManager.shared.showPopup(on: self, title: "title", SButton: "수정하기", type: .TitleSButton)
    }
}
