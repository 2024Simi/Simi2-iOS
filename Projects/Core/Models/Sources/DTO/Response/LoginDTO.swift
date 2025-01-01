//
//  LoginDTO.swift
//  Models
//
//  Created by 박서연 on 12/30/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

struct LoginDTO {
    let accessToken: String
    let refreshToken: String
    let userId: Int
    let userStatus: String
}
