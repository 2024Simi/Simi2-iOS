
//
//  TestViewController.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/10/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

class TestTextFieldViewController: UIViewController {
    
    private var nicknameInputView: FloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupNicknameField()
    }
    
    private func setupNicknameField() {
        // 커스텀 입력 뷰 설정
        nicknameInputView = FloatingLabelTextField(frame: .zero)
        nicknameInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nicknameInputView)
        
        // 제약조건 설정
        NSLayoutConstraint.activate([
            nicknameInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nicknameInputView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nicknameInputView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nicknameInputView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        // 닉네임 확인 콜백 설정
        nicknameInputView.checkNicknameStatus = { [weak self] text in
            self?.checkNicknameAvailability(text)
        }
        
        // 텍스트 변경 이벤트 처리
        nicknameInputView.textDidChangeHandler = { [weak self] text in
            // 필요한 경우 텍스트 변경 처리
            print("텍스트 변경됨: \(text ?? "")")
        }
        
        // 리턴 키 처리
        nicknameInputView.returnKeyHandler = { [weak self] in
            // 리턴 키 누를 때 처리 (예: 다음 단계로 진행)
            print("리턴 키 눌림")
        }
        
        // 추가 설정
        nicknameInputView.setKeyboardType(.default)
        nicknameInputView.setReturnKeyType(.done)
        nicknameInputView.setAutocorrectionType(.no)
        nicknameInputView.setAutocapitalizationType(.none)
    }
    
    // 닉네임 사용 가능 여부 확인 (서버 통신 시뮬레이션)
    private func checkNicknameAvailability(_ nickname: String) {
        
        // 실제로는 서버 통신 코드가 들어가야 함
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            // 예시: 2-12자 범위 내면 사용 가능으로 처리
            if nickname.count >= 2 && nickname.count <= 12 {
                self?.nicknameInputView.nicknameStatus = .available
            } else {
                self?.nicknameInputView.nicknameStatus = .unavailable
            }
        }
    }
}
