//
//  CustomCalendarViewModel.swift
//  Home
//
//  Created by 박서연 on 1/6/25.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Models
import Services

class CustomCalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var tappedDate: Date = Date()
    @Published var tappedDiaryID: Int? // tap한 다이어리의 고유 id
    @Published var diaryData: [DiaryEntity] = []
    @Published var dateTitle: String = ""
    @Published var tappedDateString: Int? // tap한 다이어리의 일자값
    @Published var underDateTitle: String = ""
    @Published var diaryDetail: DiaryDetailDTO?
    @Published var tappedDiaryPrimaryEmotion: String = ""
    @Published var tappedDiaryEntity: DiaryEntity?
    
    @Published var isDiary: Bool = false
    @Published var recordColor: UIColor = .white
    @Published var emotionLabel: String = "없어요"
    @Published var heartImage: UIImage = .icEmptyHeart
    @Published var characterImage: UIImage = .icNoRecord
    @Published var emotionColor: UIColor = .coolgray200
    @Published var recordSubLabel: String = HeartLabel.noneHeart.subLabel
    @Published var recordMainLabel: String = HeartLabel.noneHeart.mainLabel
    @Published var buttonTitle: String = DiaryLabel.recordLabel
    @Published var isPaste: Bool = false
    @Published var isToday: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private let diaryService = DiaryService(apiService: ApiService())
    
    static let koreaCalendar: Calendar = {
        var current = Calendar.current
        current.locale = Locale(identifier: "ko_KR")
        return current
    }()
    
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY.MM.dd"
        return formatter
    }()
    
    static let DateFormatterForRequest: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    enum Action {
        /// API를 통해 가져오는 서버에 저장된 일기 데이터
        case getDairyData
        /// 이전 달로 움직일 때
        case goToPreviousMonth
        /// 다음 달로 움직일때
        case goToNextMonth
        /// 오늘 버튼을 탭했을 때
        case goToToday
        /// 탭한 숫자에 해당하는 날짜의 일기 DiaryEntity 찾기
        case calculatedTappedDiaryId(Date)
        /// 일기 데이터에 맞춰서 UIKit의 날짜 라벨 업데이트
        case calculatedUnderTitle(Date)
        case formattedDate // 협의필요
        /// UIKit 컴포넌트 데이터 바인딩
        case setComponentData(PastDiaryState, EmotionType?)
        case calculatedTappedDiaryEntity(Date)
    }
    
    func send(_ action: Action) {
        switch action {
        case .getDairyData:
            let previousDate = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? Date()
            let startDate = Self.DateFormatterForRequest.string(from: previousDate)
            let endDate = Self.DateFormatterForRequest.string(from: currentMonth)
            
            if !self.diaryData.contains(where: { $0.createdString == startDate }) {
                diaryService.getDiary(startDate: startDate, endDate: endDate)
                    .receive(on: DispatchQueue.main)
                    .sink { completion in
                        switch completion {
                        case .finished:
                            print("🔵 Diary Success!")
                        case .failure(let error):
                            print("🔴 Diary Failure! \(error.localizedDescription)")
                        }
                    } receiveValue: { [weak self] diary in
                        self?.diaryData.append(contentsOf: diary)
                    }
                    .store(in: &cancellables)
            }
            
        case .goToPreviousMonth:
            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
        case .goToNextMonth:
            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
        case .goToToday:
            currentMonth = Date()
            tappedDiaryID = nil
            tappedDateString = nil
            
        case .calculatedTappedDiaryId(let date):
            
//            send(.calculatedTappedDiaryEntity(date))
//            if let diary = self.tappedDiaryEntity {
//                self.tappedDiaryID = diary.diaryId
//                let emotion = EmotionType.allCases.first { $0.englishEmotion == diary.primaryEmotion }
//                send(.setComponentData(.has, emotion))
//            } else {
//                self.tappedDiaryID = nil
//                send(.setComponentData(.none, nil))
//            }
            
            if let tempDiary = diaryData.first(where: { $0.createdDate == date }) {
                tappedDiaryID = tempDiary.diaryId
                let emotion = EmotionType.allCases.first(where: { $0.englishEmotion == tempDiary.primaryEmotion })
                send(.setComponentData(.has, emotion))
            } else {
                tappedDiaryID = nil
                send(.setComponentData(.none, nil))
            }
            
        case .calculatedTappedDiaryEntity(let date):
            guard let entity = diaryData.first(where: { $0.createdDate == date }) else { return }
            self.tappedDiaryEntity = entity
            
        case .calculatedUnderTitle(let date):
            self.underDateTitle = Self.calendarHeaderDateFormatter.string(from: date)
        case .formattedDate:
            self.dateTitle = Self.calendarHeaderDateFormatter.string(from: currentMonth)
        case .setComponentData(let state, let emotion):
            heartImage = (state == .none ? .icEmptyHeart : .icGrowingHeart)
            characterImage = (state == .none ? .icNoRecord : emotion?.image ?? .icNoRecord)
            recordColor = (state == .none) ? UIColor.white : UIColor.coolgray200
            recordSubLabel = (state == .none) ? HeartLabel.noneHeart.subLabel : HeartLabel.hasHeart.subLabel
            recordMainLabel = (state == .none) ? HeartLabel.noneHeart.mainLabel : HeartLabel.hasHeart.mainLabel
            emotionLabel = (state == .none) ? "없어요" : emotion?.rawValue ?? ""
            emotionColor = (state == .none) ? UIColor.coolgray200 : emotion?.color ?? .coolgray200
            buttonTitle = (state == .none) ? DiaryLabel.recordLabel : DiaryLabel.showLabel
        }
    }
}

extension CustomCalendarViewModel {
    // calendar action 관련 함수
    static let shortWeekly: [String] = {
        return koreaCalendar.shortWeekdaySymbols
    }()
    
    func calculatePrimaryEmotionColor(_ date: Date) -> Color {
        let temp = self.diaryData.filter { $0.createdDate ==  date }
        let color = temp.compactMap { $0.primaryEmotion }.joined()
        
        switch color {
        case "HAPPY":
            return .happy
        case "SAD":
            return .sad
        case "SOMEHOW":
            return .somehow
        case "ANGER":
            return .anger
        case "FEAR":
            return .fear
        default:
            return .happy
        }
    }
    
    func firstDayOfMonth(_ date: Date) -> Int {
        let startOfMonth = Self.koreaCalendar.date(from: Self.koreaCalendar.dateComponents([.year, .month], from: currentMonth))!
        let weekday = Self.koreaCalendar.component(.weekday, from: startOfMonth)
        return weekday - 1 // 일요일 -> 1부터 시작
    }
    
    func currentYear(_ date: Date) -> Int {
        return Self.koreaCalendar.component(.year, from: currentMonth)
    }
    
    func returnCurrentMonth(_ date: Date) -> Int {
        return Self.koreaCalendar.component(.month, from: currentMonth)
    }
    
    func dateCount(_ month: Date) -> Int {
        return Self.koreaCalendar.range(of: .day, in: .month, for: month)?.count ?? 0
    }
    
    func numberOfWeeks(in month: Date) -> Int {
        let calendar = Self.koreaCalendar
        
        guard let firstDayMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)),
              let range = calendar.range(of: .day, in: .month, for: month) else {
            return 0
        }
        
        let lastDayOfMonth = calendar.date(byAdding: .day, value: range.count - 1, to: firstDayMonth)!
        let firstWeek = calendar.component(.weekOfMonth, from: firstDayMonth)
        let lastWeek = calendar.component(.weekOfMonth, from: lastDayOfMonth)
        
        return (lastWeek - firstWeek + 1) * 7
    }
}
