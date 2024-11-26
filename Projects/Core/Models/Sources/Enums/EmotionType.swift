//
//  EmptionType.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import DesignSystem
import UIKit

public enum EmotionType: String, Decodable, CaseIterable {
    case happy = "행복"
    case sad = "슬픔"
    case angry = "분노"
    case fear = "두려움"
    case offensive = "불쾌"
    //    case somehow = "그럭저럭"
    
    public var detailEmotion: [String] {
        switch self {
        case .happy:
            ["감동적인","감사한","자신있는","재미있는","편안한","행복한","홀가분한","활기찬","자랑스러운","설레는","신나는","사랑넘치는"]
        case .sad:
            ["서운한","그리운","막막한","미안한","서러운","실망한","안타까운","후회스러운","허전한","우울한","외로운","괴로운"]
        case .fear:
            ["걱정스러운","긴장하는","무서운","깜짝놀란","불안한","혼란스러운","당황한","메스꺼운","좌절스러운","의기소침한","비참한","조마조마한"]
        case .offensive:
            ["곤란한","불편한","귀찮은","어색한","부끄러운","지루한","부담스러운","피곤한","부러운","황당한","찝찝한","매스꺼운"]
        case .angry:
            ["답답한","미운","원망스러운","지긋지긋한","짜증나는","억울한","화가나는","역겨운","신경질나는","기분이상한","눈물나는","우려스러운"]
        }
    }
    
    public var color: UIColor {
        switch self {
        case .happy:
            return UIColor.happy
        case .sad:
            return UIColor.sad
        case .angry:
            return UIColor.angry
        case .fear:
            return UIColor.fear
        case .offensive:
            return UIColor.offensive
        }
    }
    
    public var id: Int {
        switch self {
        case .happy:
            return 1
        case .sad:
            return 2
        case .angry:
            return 3
        case .fear:
            return 4
        case .offensive:
            return 5
        }
    }
    
    public func gestureEvent(direction: GestureDirection) -> EmotionType {
        guard let currentIndex = EmotionType.allCases.firstIndex(of: self) else {
            return .happy
        }
 
        let nextIndex: Int
        switch direction {
        case .right:
            nextIndex = max(currentIndex - 1, 0)
        case .left: 
            nextIndex = min(currentIndex + 1, EmotionType.allCases.count - 1)
        }
        
        return EmotionType.allCases[nextIndex]
    }
}

public enum GestureDirection {
    case right
    case left
}
