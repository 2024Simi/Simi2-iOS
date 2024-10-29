//
//  PromptEntity.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

struct PromptEntity {
    var message: PromptMessage
    var model: String
    var stream: Bool
    var temperature: Int
    var top_p: Int
    var max_tokens: Int
}

struct PromptMessage {
    var content: String
    var role: String
}
