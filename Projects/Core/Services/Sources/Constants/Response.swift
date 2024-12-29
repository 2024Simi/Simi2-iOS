//
//  Response.swift
//  Common
//
//  Created by 박서연 on 12/29/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct Response<T: Decodable>: Decodable {
    let code: String
    let status: Bool
    let data: T?
}
