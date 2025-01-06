//
//  EndPoint.swift
//  Common
//
//  Created by 박서연 on 12/29/24.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Foundation

public struct BaseUrl {
    public static let baseURL = "https://api-simi-sandbox.fun-utils.com/api/v1/"
}

public enum EndPoint: String {
    /// Auth
    case signUp = "signUp"
    case login = "login"
    case logout = "logout"
    case refresh = "refresh"
    
    /// Diary
    case diary = "diary"
    
    /// User
    case consent = "consent"
    case nickname = "nickname"
    case me = "me"
    
    /// AI Prompt Admin
    case prompt = "prompt"
    case completions = "completions"
    
    public var url: String {
        return BaseUrl.baseURL + self.rawValue
    }
}
