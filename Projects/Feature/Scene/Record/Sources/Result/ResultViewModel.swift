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
    
    public let diaryId: Int?
    public let diaryEntity: EnrollDiaryEntity
    public let diaryString: EnrollDiaryString
    public var backButton: (() -> ())?
    public var modifyButton: (() -> ())?
    public var isEditing: Bool = false
    public var resultMessage = CharacterResultEneity(
        mainEmotion: "행복",
        message: "오늘은 어떤 어떤 하루를 보냈군아, 고생 많아써. 너가 짱이야 호호호호 할말이 없다 내용내용내용 고생 많아써. 너가 짱이야 호호호호 할말이 없다 내용내용내용고생 많아써",
        mainImage: EmotionType.happy.image,
        color: .happy
    )
    
    public init(
        diaryId: Int?,
        diaryEntity: EnrollDiaryEntity,
        diaryString: EnrollDiaryString,
        backButton: (() -> Void)?,
        modifyButton: (() -> Void)?,
        isEditing: Bool,
        resultMessage: CharacterResultEneity
    ) {
        self.diaryId = diaryId
        self.diaryEntity = diaryEntity
        self.diaryString = diaryString
        self.backButton = backButton
        self.modifyButton = modifyButton
        self.isEditing = isEditing
        self.resultMessage = resultMessage
    }
    
    enum Action {
        case getDiaryDetail
        case postDiary
    }
    
    func send(_ action: Action) {
        switch action {
        case .getDiaryDetail:
            guard let id = diaryId else { return }
            
            diaryService.getDiaryDetail(diaryID: String(id))
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("🔵 Diary Detail Success!")
                    case .failure(let error):
                        print("🔴 Diary Detail Failure! \(error.localizedDescription)")
                    }
                } receiveValue: { [weak self] diary in
//                    self?.diaryDetail = diary
                }
                .store(in: &cancellables)
            
        case .postDiary:
            print("postDiary")
        }
    }
}
