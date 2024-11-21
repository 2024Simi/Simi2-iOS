//
//  DiaryService.swift
//  Common
//
//  Created by 박서연 on 2024/10/29.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import Common
import Combine
import Models
import Foundation

public protocol DiaryNetworkInterface {
    func getDiaryID(startDate: String, endDate: String) -> AnyPublisher<DiaryIdDTO, NetworkError>
    func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError>
}

public class diaryService: ApiService, DiaryNetworkInterface {
    
    private let apiService: ApiService
        
    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    public func getDiaryID(startDate: String, endDate: String) -> AnyPublisher<DiaryIdDTO, NetworkError> {
        apiService.request(httpMethod: .get, endPoint: "")
            .decode(type: DiaryIdDTO.self, decoder: JSONDecoder())
            .mapError({ error in
                return (error as? NetworkError) ?? NetworkError.apiError
            })
            .eraseToAnyPublisher()
    }
    
    public func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError> {
        apiService.request(httpMethod: .get, endPoint: "")
            .decode(type: DiaryDetailDTO.self, decoder: JSONDecoder())
            .mapError { error in
                return (error as? NetworkError) ?? NetworkError.apiError
            }
            .eraseToAnyPublisher()
    }
    
    
}
