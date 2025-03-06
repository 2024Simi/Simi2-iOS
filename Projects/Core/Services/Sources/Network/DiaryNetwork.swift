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
    func getDiary(startDate: String, endDate: String) -> AnyPublisher<[DiaryEntity], NetworkError>
    func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError>
    func postDiary(diary: PostDiaryResponse) -> AnyPublisher<PostDiaryResponse, NetworkError>
}

public class DiaryService: ApiService, DiaryNetworkInterface {
    
    private let apiService: ApiService
        
    public init(apiService: ApiService = ApiService()) {
        self.apiService = apiService
    }
    
    /// 전체 달력 데이터 가져오기 API
    public func getDiary(startDate: String, endDate: String) -> AnyPublisher<[DiaryEntity], NetworkError> {
        let parameter: [String : String] = [
            "startDate" : startDate,
            "endDate" : endDate
        ]
        return apiService.request(
            httpMethod: .get,
            endPoint: EndPoint.diary.url,
            queryParameters: parameter,
            header: masterAccessToken
        )
        .tryMap { (diaries: [DiaryDTO]) -> [DiaryEntity] in
            let mappedDiaries = diaries.map { DiaryMapper.toDiaryEntity(response: $0) }
            return mappedDiaries
        }
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.wrongMapper
        }
        .eraseToAnyPublisher()
    }
    
    /// 일기 추가
    public func postDiary(diary: PostDiaryResponse) -> AnyPublisher<PostDiaryResponse, NetworkError> {
        return request(
            httpMethod: .post,
            endPoint: EndPoint.diary.url,
            body: diary,
            header: masterAccessToken
        )
        .decode(type: PostDiaryResponse.self, decoder: JSONDecoder())
        .mapError { error in
            return (error as? NetworkError) ?? NetworkError.decodingFailed
        }
        .eraseToAnyPublisher()
    }
    
    /// 일기별 세부 데이터 가져오기
    public func getDiaryDetail(diaryID: String) -> AnyPublisher<DiaryDetailDTO, NetworkError> {        
        return apiService.request(
            httpMethod: .get,
            endPoint: EndPoint.diary.url,
            pathParameters: diaryID,
            header: masterAccessToken
        )
        .eraseToAnyPublisher()
    }
}
