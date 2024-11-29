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
         let cuostomAlert = CusotmAlert()
         cuostomAlert.configure(title: title, content: content, SButton: SButton, RButton: RButton, LButton: LButton, alertCase: type)
         
         cuostomAlert.SButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 cuostomAlert.alpha = 0
             }) { _ in
                 cuostomAlert.removeFromSuperview()
             }
         }
         
         cuostomAlert.RButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 cuostomAlert.alpha = 0
             }) { _ in
                 cuostomAlert.removeFromSuperview()
             }
         }
         
         cuostomAlert.LButtonAction = {
             UIView.animate(withDuration: 0.3, animations: {
                 cuostomAlert.alpha = 0
             }) { _ in
                 cuostomAlert.removeFromSuperview()
             }
         }

         cuostomAlert.translatesAutoresizingMaskIntoConstraints = false
         cuostomAlert.alpha = 0

         viewController.view.addSubview(cuostomAlert)
         
         NSLayoutConstraint.activate([
            cuostomAlert.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            cuostomAlert.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            cuostomAlert.widthAnchor.constraint(equalToConstant: 300),
            cuostomAlert.heightAnchor.constraint(greaterThanOrEqualToConstant: 150)
         ])
         
         UIView.animate(withDuration: 0.3) {
             cuostomAlert.alpha = 1
         }
     }
 }

