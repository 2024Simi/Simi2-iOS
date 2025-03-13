//
//  File.swift
//  Home
//
//  Created by cha_nyeong on 11/18/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Combine

public final class AgreementViewModel {
    @Published var allAgreeChecked: Bool = false
    @Published var serviceChecked: Bool = false
    @Published var privacyChecked: Bool = false
    @Published var marketingChecked: Bool = false
    @Published var isNextButtonEnabled: Bool = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        setupBindings()
    }
    
    private func setupBindings() {
        // 필수 약관 체크 상태 감시
        Publishers.CombineLatest($serviceChecked, $privacyChecked)
            .map { service, privacy in
                return service && privacy
            }
            .assign(to: \.isNextButtonEnabled, on: self)
            .store(in: &cancellables)
        
        // 개별 체크박스 상태 변경 감시
        Publishers.CombineLatest3($serviceChecked, $privacyChecked, $marketingChecked)
            .map { service, privacy, marketing in
                return service && privacy && marketing
            }
            .assign(to: \.allAgreeChecked, on: self)
            .store(in: &cancellables)
    }
    
    func toggleAllAgree() {
        let newValue = !allAgreeChecked // 현재 상태의 반대값
        allAgreeChecked = newValue
        serviceChecked = newValue
        privacyChecked = newValue
        marketingChecked = newValue
    }
}
