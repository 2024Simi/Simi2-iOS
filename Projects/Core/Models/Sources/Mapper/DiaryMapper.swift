//
//  DiaryMapper.swift
//  Common
//
//  Created by 박서연 on 12/30/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public class DiaryMapper {
    public static func toDiaryEntity(response: GetDiaryDTO) -> DiaryEntity {
        DiaryEntity(
            diaryId: response.diaryId,
            primaryEmotion: response.primaryEmotion,
            createdAt: response.createdAt
        )
    }
    
    public static func toGetDiaryByDiaryIdEntity(response: GetDiaryByDiaryIdDTO) -> GetDiaryByDiaryIdEntity {
         GetDiaryByDiaryIdEntity(
            diaryId: response.diaryId,
            episode: response.episode,
            thoughtOfEpisode: response.thoughtOfEpisode,
            resultOfEpisode: response.resultOfEpisode,
            primaryEmotion: response.primaryEmotion,
            emotionOfEpisodes: response.emotionOfEpisodes.map { dto in
                EmotionOfEpisodeEntity(
                    type: dto.type,
                    details: dto.details
                )
            },
            empathyResponse: response.empathyResponse
        )
    }
}
