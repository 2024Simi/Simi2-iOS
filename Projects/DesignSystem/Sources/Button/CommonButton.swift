//
//  Test.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/09/26.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
public class CommonButton: UIButton {
    
    public var action: (() -> Void)?
    public var text: String? = nil {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    public var isDisabled: Bool = false {
        didSet {
            self.isEnabled = !isDisabled
            setBackgroundColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
        setBackgroundColor()
        self.layer.cornerRadius = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        titleLabel?.font = FontCase.semibold(.subheadline).toUIFont
        setTitleColor(.pureWhite, for: .normal)
    }
    
    private func setBackgroundColor() {
        backgroundColor = isDisabled ? .pink100 : .pink300
    }
    
    @objc public func buttonTapped() {
        action?()
    }
    
    public func tap(action: @escaping () -> Void) {
        self.action = action
    }
}
