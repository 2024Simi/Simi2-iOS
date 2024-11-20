//
//  EmotionsViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Models
import Foundation

public class EmotionViewModel {
    public let diaryRecord: DiaryRecord
    public var selectedEmotion: EmotionType = .happy
    public var onDataUpdated: (() -> Void)?
    public var onEmotionsListUpdated: ((String) -> Void)?
    public var selectedEmotionList: [String] = []
    public var nextButton: ((String) -> Void)?
    public var backButton: (() -> ())?
    
    public init(
        diaryRecord: DiaryRecord,
        selectedEmotion: EmotionType = .happy,
        onDataUpdated: (() -> Void)? = nil,
        onEmotionsListUpdated: ((String) -> Void)? = nil,
        selectedEmotionList: [String] = [],
        nextButton: ((String) -> Void)? = nil,
        backButton: (() -> Void)? = nil
    ) {
        self.diaryRecord = diaryRecord
        self.selectedEmotion = selectedEmotion
        self.onDataUpdated = onDataUpdated
        self.onEmotionsListUpdated = onEmotionsListUpdated
        self.selectedEmotionList = selectedEmotionList
        self.nextButton = nextButton
        self.backButton = backButton
    }
    
    var detailEmotions: [String] {
        selectedEmotion.detailEmotion
    }
    
    func updateSelectedEmotion(to emotion: EmotionType) {
        selectedEmotion = emotion
        onDataUpdated?()
    }
    
    func updateEmotionsList(to emotion: String) {
        guard let index = selectedEmotionList.firstIndex(of: emotion) else {
            selectedEmotionList.append(emotion)
            return
        }
        
        selectedEmotionList.remove(at: index)
        onEmotionsListUpdated?(emotion)
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
        return "04. \(diaryRecord.rawValue)"
    }
    
    func nextButtonTapped(text: String) {
        nextButton?(text)
    }
    
    func backButtonTapped() {
        backButton?()
    }
}
