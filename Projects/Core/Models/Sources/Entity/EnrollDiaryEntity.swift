//
//  EnrollDiaryEntity.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

// post - diary
struct EnrollDiaryEntity {
//    var id = UUID().uuidString
    var episode: String
    var thoughtOfEpisode: String
    var emotionOfEpisodes: [EmotionOfEpisodes]
    var resultOfEpisode: String
    var empathyResponse: String
    var emotionOfEpisodesNotDuplicatedByType: [EmotionOfEpisodes]
}
