//
//  GetDiaryRequest.swift
//  Models
//
//  Created by 박서연 on 3/10/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation

/// 시작날짜 - 마지막 날짜로 일기 데이터를 가져올 때 사용하는 Request입니다.
/// diary-Controller > /api/vi/diary 에서 사용됩니다.
struct GetDiaryRequest: Encodable {
    let startDate: String
    let endDate: String
    
    init(
        startDate: String,
        endDate: String
    ) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
