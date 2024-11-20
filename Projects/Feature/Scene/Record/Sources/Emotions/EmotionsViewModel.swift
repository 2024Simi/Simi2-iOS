//
//  EmotionsViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Models
import Foundation

class EmotionViewModel {
    var selectedEmotion: EmotionType = .happy
    var onDataUpdated: (() -> Void)?
    var onEmotionsListUpdated: (() -> Void)?
    var selectedEmotionList: [String] = []
    var selectedDetails: [String: Set<String>] = [:]
    
    var detailEmotions: [String] {
        selectedEmotion.detailEmotion
    }
    
    func updateSelectedEmotion(to emotion: EmotionType) {
        selectedEmotion = emotion
        onDataUpdated?()
    }
    
    func updateEmotionsList(to emotion: String) {
        selectedEmotionList.append(emotion)
        onEmotionsListUpdated?()
    }
    
    func toggleDetailSelection(for emotion: EmotionType, detail: String) {
            guard var details = selectedDetails[emotion.rawValue] else { return }
            if details.contains(detail) {
                details.remove(detail)
            } else {
                details.insert(detail)
            }
            selectedDetails[emotion.rawValue] = details
        }
    
    func isDetailSelected(for emotion: EmotionType, detail: String) -> Bool {
        return selectedDetails[emotion.rawValue]?.contains(detail) ?? false
    }
}
