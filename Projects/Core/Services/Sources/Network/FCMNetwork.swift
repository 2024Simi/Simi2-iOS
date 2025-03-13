//
//  FCMNetwork.swift
//  Services
//
//  Created by 박서연 on 2/27/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import Combine
import Foundation

import Common
import Models

public protocol FCMNetworkInferface {
    func putNotification(_ fcmInfo: NotificationRequest) -> AnyPublisher<NotificationDTO, NetworkError>
}

public class FCMNetworkService: ApiService, FCMNetworkInferface {
    
    private let apiService: ApiService
    
    public init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    /// 알람 설정
    public func putNotification(_ fcmInfo: Models.NotificationRequest) -> AnyPublisher<NotificationDTO, NetworkError> {
        return apiService.request(
            httpMethod: .put,
            endPoint: EndPoint.diary.url,
            body: fcmInfo,
            header: masterAccessToken // 추후 수정
        )
        .decode(type: NotificationDTO.self, decoder: JSONDecoder())
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.decodingFailed
        }
        .eraseToAnyPublisher()
    }
}
