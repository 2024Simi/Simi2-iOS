//
//  servicedumy.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/25.
//

import Foundation

public enum NetworkError: Error {
    case apiError
    case urlError
    case statusError
    case queryError
    case badRequest
    case notConnected
    case response
    case decode
    case encode
    case refresh
    case unknown
}
