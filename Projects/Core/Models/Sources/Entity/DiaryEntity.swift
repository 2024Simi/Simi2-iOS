//
//  DiaryEntity.swift
//  Models
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct DiaryEntity {
    public let event: String
    public let behavior: String
    public let think: String
    public let emotions: [String]
    
    public init(event: String, behavior: String, think: String, emotions: [String]) {
        self.event = event
        self.behavior = behavior
        self.think = think
        self.emotions = emotions
    }
}

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
