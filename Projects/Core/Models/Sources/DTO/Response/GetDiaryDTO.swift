//
//  DiaryDTO.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

/// 시작날짜-마지막날짜를 통해서 일정 날짜 사이의 일기 데이터를 가져옵니다.
/// - Parameter :
///   - Start Date: 시작날짜
///   - End Date : 마지막 날짜
public struct GetDiaryDTO: Decodable {
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

/// DiaryController - /diary/diaryId API
///  - result : diaryID로 가져오는 해당 아이디 값의 다이어리 정보
public struct GetDiaryByDiaryIdDTO: Decodable {
    /// diaryID
    public var diaryId: Int
    /// 오늘은 어떤일이 있었어? 의 "사건"
    public var episode: String
    /// 그 일에 대해서 어떤 생각이 들었어? 의 "생각"
    public var thoughtOfEpisode: String
    /// 그래서 어떤 행동을 했어?의 "행동"
    public var resultOfEpisode: String
    /// 오늘의 주감정
    public var primaryEmotion: String
    /// 오늘 선택한 감정들
    public var emotionOfEpisodes: [EmotionOfEpisode]
    /// 시미의 반응 문구
    public var empathyResponse: String
    
    /// vm 단에서 사용하기 위한 초기값을 위한 init
    public init() {
        self.diaryId = 0
        self.episode = ""
        self.thoughtOfEpisode = ""
        self.resultOfEpisode = ""
        self.primaryEmotion = ""
        self.emotionOfEpisodes = []
        self.empathyResponse = ""
    }
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
