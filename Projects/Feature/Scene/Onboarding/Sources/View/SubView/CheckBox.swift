//
//  CheckBox.swift
//  Home
//
//  Created by cha_nyeong on 12/6/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import DesignSystem

public final class CheckBox: UIImageView {
    // 체크박스 이미지
    private var checkEnableImage: UIImage = .icEnableCheck
    private var checkDisableImage: UIImage = .icDisableCheck
    
    // 체크 상태
    var isChecked: Bool = false {
        didSet {
            guard isChecked != oldValue else { return }
            setChecked(isChecked)
        }
    }
    
    // 탭 핸들러
    var checkBoxTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewDidLoad()
    }
    
    private func viewDidLoad() {
        isUserInteractionEnabled = true
        image = checkDisableImage
        
        // 탭 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        isChecked.toggle()
        checkBoxTapped?()
    }
    
    private func setChecked(_ isChecked: Bool) {
        image = isChecked ? checkEnableImage : checkDisableImage
    }
    
//    func setCheckBoxImages(onImage: UIImage, offImage: UIImage) {
//        self.checkEnableImage = onImage
//        self.checkDisableImage = offImage
//        setChecked(isChecked)
//    }
}
