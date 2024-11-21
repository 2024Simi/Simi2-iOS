//
//  DiaryDTO.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct DiaryIdDTO: Decodable {
    var diaryId: Int
    var createdAt: String
}

public struct DiaryDetailDTO: Decodable {
    var diaryId: Int
    var episode: String
    var emotionOfEpisodes: [EmotionOfEpisodes]
    var resultOfEpisode: String
    var empathyResponse: String
}

// 감정 선택뷰에서 선택하는
// 행복 탭에서 감정 여러개 선택
public struct EmotionOfEpisodes: Decodable {
    var type: EmotionType
    var details: [String]
}


