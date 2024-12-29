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
    func getDiary(startDate: String, endDate: String) -> AnyPublisher<DiaryDTO, NetworkError>
    func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError>
    func postDiary(diary: PostDiaryResponse) -> AnyPublisher<PostDiaryResponse, NetworkError>
}

public class diaryService: ApiService, DiaryNetworkInterface {
    
    private let apiService: ApiService
        
    init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    public func getDiary(startDate: String, endDate: String) -> AnyPublisher<DiaryDTO, NetworkError> {
        let parameter: [String : String] = [
            "startDate" : startDate,
            "endDate" : endDate
        ]
        
        return apiService.request(
            httpMethod: .get,
            endPoint: EndPoint.diary.url,
            queryParameters: parameter,
            header: "" // header 필수인지 아닌지 확인
        )
        .decode(type: DiaryDTO.self, decoder: JSONDecoder())
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.decodingFailed(error: error)
        }
        .eraseToAnyPublisher()
    }
    
    public func postDiary(diary: PostDiaryResponse) -> AnyPublisher<PostDiaryResponse, NetworkError> {
        
        return request(
            httpMethod: .post,
            endPoint: EndPoint.diary.url,
            body: diary,
            header: ""
        )
        .decode(type: PostDiaryResponse.self, decoder: JSONDecoder())
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.decodingFailed(error: error)
        }
        .eraseToAnyPublisher()
    }
    
    public func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError> {
        let parameter: [String : String] = [
            "diaryId" : diaryID
        ]
        
        return apiService.request(
            httpMethod: .get,
            endPoint: EndPoint.diary.url,
            queryParameters: parameter,
            header: ""
        )
        .decode(type: DiaryDetailDTO.self, decoder: JSONDecoder())
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.decodingFailed(error: error)
        }
        .eraseToAnyPublisher()
    }
}
