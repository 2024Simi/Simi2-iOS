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
    
    
    
    // MARK: - diary test data
    static let testDiarys: [DiaryDTO] = [
        .init(diaryId: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-01T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "SAD", createdAt: "2024-12-02T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "ANGRY", createdAt: "2024-12-03T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "FAER", createdAt: "2024-12-04T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "SOMEHOW", createdAt: "2024-12-05T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-06T06:19:26.417Z"),
        .init(diaryId: 0, primaryEmotion: "OFFENSIVE", createdAt: "2024-12-07T06:19:26.417Z")
    ]
}

public struct DiaryIdDTO: Decodable {
    var diaryId: Int
    var createdAt: String
}

public struct DiaryDetailDTO: Decodable {
    var diaryId: Int
    var episode: String
    var thoughtOfEpisode: String
    var emotionOfEpisodes: [EmotionOfEpisodes]
    var primaryEmption: EmotionType
    var resultOfEpisode: String
    var empathyResponse: String
}

// 감정 선택뷰에서 선택하는
// 행복 탭에서 감정 여러개 선택
public struct EmotionOfEpisodes: Decodable {
    let type: EmotionType
    let details: [String]
}

/// diary post result
public struct PostDiaryResponse: Codable {
    let diaryId: Int
    let empathyResponse: String
}
