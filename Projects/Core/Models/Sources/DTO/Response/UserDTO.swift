//
//  UserDTO.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct UserDTO: Decodable {
    var id: Int
    var profileImageUrl: String
    var nickname: String
    var provider: LoginType
    var isPrivatePolicyAgreed: Bool
    var isProfileSettings: Bool
}

