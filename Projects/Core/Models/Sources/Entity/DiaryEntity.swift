//
//  EnrollDiaryEntity.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

/// get diary -> response의 DairyDTO를 앱 내부에서 사용하기 위해서 Entity로 변환 예정
public struct DiaryEntity {
    public var diaryId: Int
    public var primaryEmotion: String
    public var createdAt: String
    
    public var id = UUID().uuidString
    public var createdDate: Date? {
        let temp = String(createdAt.prefix(10))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: temp) {
            return date
        }
        
        return nil
    }
    
    public var createdString: String {
        return String(createdAt.prefix(10))
    }
}
