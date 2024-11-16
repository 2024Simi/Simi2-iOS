//
//  BasedUIComponent.swift
//  Common
//
//  Created by cha_nyeong on 10/22/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

open class BaseViewController<ViewModelType>: UIViewController {
    let viewModel: ViewModelType

    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureAttributes()
        configureUI()
        bind()
    }
    
    /// viewModel data binding
    open func bind() {
        
    }
    
    // UI 설정에 관한 모든 메서드 호출
    open func configureUI() {
        setAutoLayout()
        setAttributes()
    }
    
    open func configureAttributes() {
        hideKeyboardWhenTapped()
    }
    /// autoLayout 설정
    open func setAutoLayout() {
        
    }
    
    /// 이외의 attributes 설정
    open func setAttributes() {
//        navigationController?.navigationBar.isHidden = true
//        view.backgroundColor = .systemBackground
    }
}
