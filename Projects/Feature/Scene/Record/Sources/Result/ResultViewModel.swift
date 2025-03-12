//
//  ResultViewModel.swift
//  Home
//
//  Created by 박서연 on 2024/11/25.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import UIKit
import Models
import Services
import Combine

public struct CharacterResultEneity {
    let mainEmotion: String
    let message: String
    let mainImage: UIImage
    let color: UIColor
}

public class ResultViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    private let diaryService = DiaryService(apiService: ApiService())

    /// diaryId
    public let diaryId: Int
    /// 일기 수정 후 다시 서버에 데이터를 보내기 위한 post Request
    public let diaryEntity: PostDiaryRequest
    /// diaryID를 통해서 가져오는 다이어리 데이터
    public var diaryDataById = CurrentValueSubject<GetDiaryByDiaryIdEntity, Never>(.init())
    /// 뒤로가기
    public var backButton: (() -> ())?
    /// 수정하기
    public var modifyButton: (() -> ())?
    /// 수정인지 아닌지
    public var isEditing: Bool

    public init(
        diaryId: Int,
        diaryEntity: PostDiaryRequest = .init(),
        backButton: (() -> Void)? = nil,
        modifyButton: (() -> Void)? = nil,
        isEditing: Bool = false
    ) {
        self.diaryId = diaryId
        self.diaryEntity = diaryEntity
        self.backButton = backButton
        self.modifyButton = modifyButton
        self.isEditing = isEditing
    }
    
    enum Action {
        /// DiaryID를 통해 특정 ID의 일기 데이터 불러옵니다.
        case getDiaryDetailByID
        /// 일기를 서버에 기록합니다.
        case postDiary
    }
    
    func send(_ action: Action) {
        switch action {
        case .getDiaryDetailByID:
            diaryService.getDiaryDetail(diaryID: "\(diaryId)")
                .receive(on: DispatchQueue.main) // 메인 스레드에서 UI 작업
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("🔵 Diary Detail Success!")
                    case .failure(let error):
                        print("🔴 Diary Detail Failure! \(error.localizedDescription)")
                    }
                } receiveValue: { [weak self] diary in
                    self?.diaryDataById.send(diary) // 값 방출
                }
                .store(in: &cancellables)
            
        case .postDiary:
            print("postDiary")
        }
    }
}
