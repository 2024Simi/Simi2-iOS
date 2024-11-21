//
//  UIStackView+Ex.swift
//  Common
//
//  Created by cha_nyeong on 10/22/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for v in views {
            self.addArrangedSubview(v)
        }
    }
}
