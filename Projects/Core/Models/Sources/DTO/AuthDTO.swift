//
//  AuthDTO.swift
//  Services
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct PostAuthDTO: Encodable {
    var accessToken: String
    var refreshToken: String
    var userID: Int
}
