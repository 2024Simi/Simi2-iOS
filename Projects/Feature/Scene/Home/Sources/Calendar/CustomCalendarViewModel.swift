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
    @Published var tappedDiaryID: Int?
    @Published var diaryData: [DiaryEntity] = []
    @Published var dateTitle: String = ""
    @Published var tappedDateString: Int?
    @Published var underDateTitle: String = ""
    
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
        case getDairyData
        case calculatedTappedDiaryId(Date)
        case calculatedUnderTitle(Date)
        case formattedDate
        case updateComponentData
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
            
        case .calculatedTappedDiaryId(let date):
            let temp = self.diaryData.filter { $0.createdDate == date }.first
            self.tappedDiaryID = temp?.diaryId ?? 0
            
        case .calculatedUnderTitle(let date):
            self.underDateTitle = Self.calendarHeaderDateFormatter.string(from: date)
            
        case .formattedDate:
            self.dateTitle = Self.calendarHeaderDateFormatter.string(from: currentMonth)
            
        case .updateComponentData:
            print("update")
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
    
    func goToPreviousMonth() {
        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    func goToNextMonth() {
        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
    
    func goToToday() {
        currentMonth = Date()
        tappedDiaryID = nil
        tappedDateString = nil
    }
}
