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
    public let diaryEntity: DiaryEntity
    public let diaryString: DiaryString
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
        diaryEntity: DiaryEntity,
        diaryString: DiaryString
    ) {
        self.diaryEntity = diaryEntity
        self.diaryString = DiaryString(
            eventString: diaryEntity.event,
            behaviorString: diaryEntity.behavior,
            thinkString: diaryEntity.think
        )
    }
    
    
}


/*
 public class BehaviorViewModel {
 public let diaryRecord: DiaryRecord
 public var nextButton: ((String) -> Void)?
 public var backButton: (() -> ())?
 
 public init(diaryRecord: DiaryRecord) {
 self.diaryRecord = diaryRecord
 }
 
 public var questionText: String {
 return diaryRecord.question
 }
 
 public var placeholderText: String {
 return diaryRecord.placeholder
 }
 
 public var assistance: String {
 return diaryRecord.assistance
 }
 
 public var titleText: String {
 return "03. \(diaryRecord.rawValue)"
 }
 
 func nextButtonTapped(text: String) {
 nextButton?(text)
 }
 
 func backButtonTapped() {
 backButton?()
 }
 }
 */
