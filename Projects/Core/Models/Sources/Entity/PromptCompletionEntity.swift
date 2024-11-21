//
//  PromptCompletionEntity.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation


struct PromptCompletionEntity {
    var message: [PromptMessage]
    var model: String
    var stream: Bool
    var temparture: Int
    var top_p: Int
    var max_tokens: Int
}

