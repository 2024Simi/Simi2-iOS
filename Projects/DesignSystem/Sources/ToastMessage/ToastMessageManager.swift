//
//  ToastMessageManager.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/30.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public class ToastMessageManager {
    public static let shared = ToastMessageManager()

    private init() {}
        
    public func showToastMessage(
        on viewController: UIViewController,
        message: String,
        type: ToastCase,
        postition: ToastPosition
    ) {
        print("tapped??????")
        let toast = ToastMessage()
        toast.configure(message: message, type: type)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.alpha = 0
        
        viewController.view.addSubview(toast)
        
        switch postition {
        case .up:
            NSLayoutConstraint.activate([
                toast.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: 60),
                toast.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
                toast.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16)
            ])
        case .down:
            NSLayoutConstraint.activate([
                toast.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 81),
                toast.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 16),
                toast.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -16)
            ])
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            toast.alpha = 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                UIView.animate(withDuration: 0.2, animations: {
                    toast.alpha = 0
                }) { _ in
                    toast.removeFromSuperview()
                }
            }
        }

    }
}
