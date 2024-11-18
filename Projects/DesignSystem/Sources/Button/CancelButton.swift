//
//  CancelButton.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public class CancelButton: UIButton {
    
    public var action: (() -> Void)?
    public var text: String? = nil {
        didSet {
            setTitle(text, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        titleLabel?.font = FontCase.semibold(.caption1).toUIFont
        titleLabel?.textColor = .coolgray400
        setTitleColor(.coolgray400, for: .normal)
    }
    
    @objc public func buttonTapped() {
        action?()
    }
    
    public func tap(action: @escaping () -> Void) {
        self.action = action
    }
}
