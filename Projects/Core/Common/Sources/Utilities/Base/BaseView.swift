//
//  BaseView.swift
//  Common
//
//  Created by cha_nyeong on 11/15/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

class BaseView<ViewModelType>: UIView {
    var viewModel: ViewModelType?
    
    convenience init(viewModel: ViewModelType) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        bind(viewModel: viewModel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: ViewModelType) {
        
    }
    
    func configureUI() {
        setAutoLayout()
        setAttributes()
    }
    
    func setAutoLayout() {
        
    }
    
    func setAttributes() {

    }
}
