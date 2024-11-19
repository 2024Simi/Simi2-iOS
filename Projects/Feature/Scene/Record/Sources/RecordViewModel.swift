//
//  RecordViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/19.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Models

public class RecordViewModel {
    private let diaryRecord: DiaryRecord
    
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
        return "01. \(diaryRecord.rawValue)"
    }
}

