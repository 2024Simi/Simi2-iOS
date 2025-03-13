//
//  NotiSettingViewModel.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import UIKit
import Combine

public class NotiSettingViewModel {
    
    @Published public var selectedTimeOption: TimeOption?
    @Published public var customTime: Date = Date()
    @Published public var shouldShowTimePicker: Bool = false
    @Published public var customTimeFormatted: String = ""
    
    public init() {}
    
    public func selectTimeOption(_ option: TimeOption) {
        if option == .custom {
            shouldShowTimePicker = true
        } else {
            selectedTimeOption = option
            shouldShowTimePicker = false
        }
    }
    
    public func confirmCustomTime() {
        selectedTimeOption = .custom
        shouldShowTimePicker = false
        
        // 선택한 시간을 포맷팅하여 저장 (분 없이 시간과 AM/PM만 표시)
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        customTimeFormatted = formatter.string(from: customTime)
    }
    
    public func cancelCustomTime() {
        shouldShowTimePicker = false
    }
    
    // 선택된 시간 옵션에 대한 텍스트 반환 (custom 옵션일 경우 포맷팅된 시간 사용)
    public func getTimeText(for option: TimeOption) -> String {
        if option == .custom && selectedTimeOption == .custom {
            return customTimeFormatted.isEmpty ? "시간 선택" : customTimeFormatted
        }
        return option.time
    }
}
