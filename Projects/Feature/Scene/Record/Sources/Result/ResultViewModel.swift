//
//  ResultViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Models

public struct CharacterResultEneity {
    let mainEmotion: String
    let message: String
    let mainImage: UIImage
    let color: UIColor
}

public class ResultViewModel {
    public let diaryEntity: EnrollDiaryEntity
    public let diaryString: EnrollDiaryString
    public var backButton: (() -> ())?
    public var modifyButton: (() -> ())?
    public var isEditing: Bool = false
    public var resultMessage = CharacterResultEneity(
        mainEmotion: "행복",
        message: "오늘은 어떤 어떤 하루를 보냈군아, 고생 많아써. 너가 짱이야 호호호호 할말이 없다 내용내용내용 고생 많아써. 너가 짱이야 호호호호 할말이 없다 내용내용내용고생 많아써",
        mainImage: EmotionType.happy.image,
        color: .happy
    )
    
    public init(
        diaryEntity: EnrollDiaryEntity,
        diaryString: EnrollDiaryString
    ) {
        self.diaryEntity = diaryEntity
        self.diaryString = EnrollDiaryString(
            eventString: diaryEntity.event,
            behaviorString: diaryEntity.behavior,
            thinkString: diaryEntity.think
        )
    }
}
