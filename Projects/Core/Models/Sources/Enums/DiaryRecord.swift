//
//  DiaryRecord.swift
//  Models
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit

public enum DiaryRecord: String {
    case event = "사건"
    case think = "생각"
    case behavior = "행동"
    case emotions = "감정"
    
    public var question: String {
        switch self {
        case .event:
            return "서연님의 하루가 궁금해요"
        case .think:
            return "님의 생각이 궁금해요"
        case .behavior:
            return "님의 행동이 궁금해요"
        case .emotions:
            return "님의 감정이 궁금해요"
        }
    }
    
    public var assistance: String {
        switch self {
        case .event:
            return "오늘 하루는 어땠어?"
        case .think:
            return "그때 어떤 생각이 들었어?"
        case .behavior:
            return "그래서 어떤 행동을 했어?"
        case .emotions:
            return "네가 느꼈던 감정을 고른다면 어떤 단어로 표현될까?"
        }
    }
    
    public var placeholder: String {
        switch self {
        case .event:
            return "오늘 마감기한을 못 맞춰서 파트장님한테 공개적으로 꼽을 먹었어... \n오늘 일어난 일에 대해서 적어주세요"
        case .think:
            return "think placeholder"
        case .behavior:
            return "behavior placeholder"
        case .emotions:
            return "emotions placeholder"
        }
    }
}
