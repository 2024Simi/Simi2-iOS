//
//  UIView+Ex.swift
//  Common
//
//  Created by cha_nyeong on 10/22/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for v in views {
            self.addSubview(v)
        }
    }
}
