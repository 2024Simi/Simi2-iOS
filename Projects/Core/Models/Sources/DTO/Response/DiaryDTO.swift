//
//  DiaryDTO.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

/// api/v1/diary
public struct DiaryDTO: Decodable {
    public let diaryId: Int
    public let primaryEmotion: String
    public let createdAt: String
    
    // Entity를 위한 변수 추가
    public var createdDate: Date? {
        let temp = String(createdAt.prefix(10))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: temp) {
            return date
        }
        
        return nil
    }
    
    public var emotionType: EmotionType? {
        return EmotionType.allCases.first { $0.rawValue == primaryEmotion }
    }
}

public struct DiaryIdDTO: Decodable {
    public var diaryId: Int
    public var createdAt: String
}

public struct DiaryDetailDTO: Decodable {
    public var diaryId: Int
    public var episode: String
    public var thoughtOfEpisode: String
    public var emotionOfEpisodes: [EmotionOfEpisode]
    public var primaryEmotion: String
    public var resultOfEpisode: String
    public var empathyResponse: String
}

// 감정 선택뷰에서 선택하는
// 행복 탭에서 감정 여러개 선택
public struct EmotionOfEpisode: Decodable {
    public let type: String
    public let details: [String]
}

/// diary post result
public struct PostDiaryResponse: Codable {
    public let diaryId: Int
    public let empathyResponse: String
}
