//
//  ResultViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation
import Models

public class ResultViewModel {
    public let diaryEntity: DiaryEntity
    public let diaryString: DiaryString
    public var backButton: (() -> ())?
    public var modifyButton: (() -> ())?
    
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
