//
//  DiaryEntity.swift
//  Models
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

/// 일기 기록 및 수정 시 서버로 일기 데이터를 보낼 때 사용하기 위한 Request Data 입니다.
public struct PostDiaryRequest {
    public let event: String
    public let behavior: String
    public let think: String
    public let emotions: [String]
    
    public init(
        event: String,
        behavior: String,
        think: String,
        emotions: [String]
    ) {
        self.event = event
        self.behavior = behavior
        self.think = think
        self.emotions = emotions
    }
    
    /// 일기 수정 시 사용하기 위한 임시 public init
    public init() {
        self.event = ""
        self.behavior = ""
        self.think = ""
        self.emotions = []
    }
}

/// 일기 관련 명칭을 위한 구조체입니다.
public struct DiaryString: Sequence {
    public let event = "사건"
    public let behavior = "생각"
    public let think = "행동"
    
    public let eventString: String
    public let behaviorString: String
    public let thinkString: String
    
    public init(
        eventString: String,
        behaviorString: String,
        thinkString: String
    ) {
        self.eventString = eventString
        self.behaviorString = behaviorString
        self.thinkString = thinkString
    }
    
    public func makeIterator() -> Array<String>.Iterator {
        return [eventString, behaviorString, thinkString].makeIterator()
    }
}
