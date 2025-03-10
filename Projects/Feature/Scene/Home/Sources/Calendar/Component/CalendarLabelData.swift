//
//  CalendarLabelData.swift
//  Home
//
//  Created by 박서연 on 1/9/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation

public struct HeartLabel {
    public let subLabel: String
    public let mainLabel: String
    
    public static let noneHeart: HeartLabel = HeartLabel(subLabel: "아직 기록이 없어요", mainLabel: "오늘을\n기록해주세요!")
    public static let hasHeart: HeartLabel = HeartLabel(subLabel: "매일 감정을 기록해봐요", mainLabel: "이날도\n고생많았어요")
}

public struct DiaryLabel {
    public static let todayMainLabel = "오늘의 주 감정은"
    public static let recordLabel = "감정 기록하기"
    public static let showLabel = "기록 보러가기"
}

public enum DiaryState {
    case none
    case has
}
