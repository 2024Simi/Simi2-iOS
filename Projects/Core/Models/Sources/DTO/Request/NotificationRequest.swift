//
//  NotificationRequest.swift
//  Models
//
//  Created by 박서연 on 2/27/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation

public struct NotificationRequest: Encodable {
    let fcnToken: String
    let notificationTime: NotificationTimeRequest
}

public struct NotificationTimeRequest: Encodable {
    let hour: Int
    let minute: Int
    let second: Int
    let nano: Int
}
