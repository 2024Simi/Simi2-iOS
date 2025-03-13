//
//  TimeModel.swift
//  Onboarding
//
//  Created by cha_nyeong on 3/12/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

public enum TimeOption: Int, CaseIterable {
    case dawn = 0
    case morning = 1
    case noon = 2
    case afternoon = 3
    case evening = 4
    case custom = 5
    
    public var title: String {
        switch self {
        case .dawn: return "새벽"
        case .morning: return "아침"
        case .noon: return "정오"
        case .afternoon: return "오후"
        case .evening: return "저녁"
        case .custom: return "직접 시간설정"
        }
    }
    
    public var time: String {
        switch self {
        case .dawn: return "12AM"
        case .morning: return "8AM"
        case .noon: return "12PM"
        case .afternoon: return "1PM"
        case .evening: return "8PM"
        case .custom: return "직접 시간설정"
        }
    }
    
    public var icon: UIImage {
        switch self {
        case .dawn: return .icDawn
        case .morning: return .icMorning
        case .noon: return .icNoon
        case .afternoon: return .icAfternoon
        case .evening: return .icEvening
        case .custom: return .icDirectSelection
        }
    }
}
