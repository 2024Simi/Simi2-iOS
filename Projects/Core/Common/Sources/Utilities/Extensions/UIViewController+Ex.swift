//
//  UIViewController+Ex.swift
//  Common
//
//  Created by cha_nyeong on 11/16/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        // 기본값이 true이면 제스쳐 발동시 터치 이벤트가 뷰로 전달x
        // 즉 제스쳐가 동작하면 뷰의 터치이벤트는 발생하지 않는것 false면 둘 다 작동한다는 뜻
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
