//
//  CreateDiaryDTO.swift
//  Common
//
//  Created by 박서연 on 12/29/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

//public struct CreateDiaryDTO {
//    let episode: String
//    let thoughtOfEpisode: String
//    let emotionOfEpisodes: [EmotionOfEpisodes]
//    let resultOfEpisode: String
//    let emotionOfEpisodesNotDuplicatedByType: [EmotionOfEpisodes]
//}

struct PostDiaryDTO {
//    var id = UUID().uuidString
    var episode: String
    var thoughtOfEpisode: String
    var emotionOfEpisodes: [EmotionOfEpisode]
    var resultOfEpisode: String
    var empathyResponse: String
    var emotionOfEpisodesNotDuplicatedByType: [EmotionOfEpisode]
}
