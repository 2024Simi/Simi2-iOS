//
//  ConsentRequest.swift
//  Models
//
//  Created by 박서연 on 3/4/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Foundation

public struct ConsentRequest: Encodable {
    let isAgreePrivatePolicy: Bool
    let isAgreeTermsOfService: Bool
    let isAgreeMarketing: Bool
}
