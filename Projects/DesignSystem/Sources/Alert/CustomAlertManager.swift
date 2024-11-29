//
//  CustomAlertManager.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

 public class PopupManager {
     public static let shared = PopupManager()

     private init() {}

     public func showPopup(on viewController: UIViewController, title: String, content: String? = nil, LButton: String? = nil, RButton: String? = nil, SButton: String? = nil, type: AlertCase) {
         let customAlert = CusotmAlert()
         customAlert.configure(title: title, content: content, SButton: SButton, RButton: RButton, LButton: LButton, alertCase: type)
         
         customAlert.SButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 customAlert.alpha = 0
             }) { _ in
                 customAlert.removeFromSuperview()
             }
         }
         
         customAlert.RButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 customAlert.alpha = 0
             }) { _ in
                 customAlert.removeFromSuperview()
             }
         }
         
         customAlert.LButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 customAlert.alpha = 0
             }) { _ in
                 customAlert.removeFromSuperview()
             }
         }

         customAlert.translatesAutoresizingMaskIntoConstraints = false
         customAlert.alpha = 0

         viewController.view.addSubview(customAlert)
         
         NSLayoutConstraint.activate([
            customAlert.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            customAlert.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            customAlert.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            customAlert.topAnchor.constraint(equalTo: viewController.view.topAnchor),
         ])
         
         UIView.animate(withDuration: 0.3) {
             customAlert.alpha = 1
         }
     }
 }

