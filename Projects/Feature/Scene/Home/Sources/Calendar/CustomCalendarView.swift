//
//  CustomCalendarView.swift
//  Home
//
//  Created by 박서연 on 2024/12/10.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine

struct CustomCalendarView: View {
    @ObservedObject var viewModel: CustomCalendarViewModel
    
    private var preMonth: Date {
        return CustomCalendarViewModel.koreaCalendar.date(byAdding: .month, value: -1, to: viewModel.currentMonth)!
    }
    
    private func returnOpacity() -> Bool {
        let calendar = Calendar.current
        let currentMonthStart = calendar.startOfDay(for: viewModel.currentMonth)
        let thisMonthStart = calendar.startOfDay(for: Date())
        
        return currentMonthStart == thisMonthStart
    }
    
    var body: some View {
        VStack(spacing: 12) {
            let circleWidth = ((UIScreen.main.bounds.width - 52) / 7) - 8
            
            HStack(spacing: 8) {
                SText(viewModel.formattedDate(), fontType: .bold(.title3), color: .gray900)
                Image.icChevronLeft
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        viewModel.goToPreviousMonth()
                    }
                
                Image.icChevronRight
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.leading, -8)
                    .onTapGesture {
                        viewModel.goToNextMonth()
                    }
                
                Spacer()
                
                SText("오늘", fontType: .semibold(.footnote), color: .white)
                    .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color.gray800)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .onTapGesture {
                        viewModel.goToToday()
                    }
            }
            .frame(height: 48)
            .padding(.horizontal, 16)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
                ForEach(CustomCalendarViewModel.shortWeekly, id: \.self) { data in
                    SText(data, fontType: .semibold(.caption1))
                        .frame(width: circleWidth, height: 22)
                        .foregroundStyle(data == "일" ? Color.red : Color.black)
                }
                .padding(.vertical, 12)
                
                let lastDateOfCalendar = viewModel.numberOfWeeks(in: viewModel.currentMonth) - viewModel.firstDayOfMonth(viewModel.currentMonth)
                
                ForEach((-viewModel.firstDayOfMonth(viewModel.currentMonth)+1) ... lastDateOfCalendar, id: \.self) { date in
                    let column = (date + viewModel.firstDayOfMonth(viewModel.currentMonth) - 1) % 7 == 0
                    let dateComponent = DateComponents(
                        year: viewModel.currentYear(viewModel.currentMonth),
                        month: viewModel.returnCurrentMonth(viewModel.currentMonth),
                        day: date
                    )
                    let calculatedDateComponent = Calendar.current.date(from: dateComponent) ?? Date()
                    let isToday = Calendar.current.isDateInToday(calculatedDateComponent)
                    let isPastDate = calculatedDateComponent < Calendar.current.startOfDay(for: Date())
                    let isMatched = viewModel.diaryData.contains { $0.createdDate == calculatedDateComponent }
                    
                    VStack(spacing: 0) {
                        Circle()
                            .fill(Color.happy)
                            .frame(width: 4, height: 4)
                            .opacity(isMatched ? 1.0 : 0.0)
                        
                        if date <= 0 {
                            let preDate = viewModel.dateCount(preMonth) + date
                            SText("\(preDate)", fontType: viewModel.tappedDiaryID == date ? .bold(.body) : .semibold(.body), color: date+viewModel.firstDayOfMonth(preMonth) == 1 ? .red : .black)
                                .opacity(viewModel.tappedDiaryID == date ? 1.0 : (isPastDate ? 0.5 : 1.0))
                                .frame(width: circleWidth, height: 40)
                            
                        } else if date > 0 && date <= viewModel.dateCount(viewModel.currentMonth) {
                            if isToday {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: circleWidth, height: 40)
                                    .overlay {
                                        Circle()
                                            .frame(width: circleWidth-8, height: 32)
                                            .overlay {
                                                SText("\(date)", fontType: .semibold(.body), color: .white)
                                            }
                                    }
                            } else {
                                SText("\(date)", fontType: viewModel.tappedDiaryID == date ? .bold(.body) : .semibold(.body), color: column ? Color.red : Color.black)
                                    .frame(width: circleWidth, height: 40)
                                    .opacity(viewModel.tappedDiaryID == date ? 1.0 : (isPastDate ? 0.5 : 1.0))
                            }
                        } else {
                            let nextMonthDay = date - viewModel.dateCount(viewModel.currentMonth)
                            SText("\(nextMonthDay)", fontType: viewModel.tappedDiaryID == date ? .bold(.body) : .semibold(.body), color: column ? Color.red : Color.black)
                                .frame(width: circleWidth, height: 40)
                                .opacity(isPastDate ? 0.5 : 1.0)
                        }
                    }
                    .frame(height: 44)
                    .onTapGesture {
                        if isPastDate {
                            viewModel.tappedDiaryID = date
                            viewModel.tappedDate = calculatedDateComponent
                        }
                    }
                    .background(viewModel.tappedDiaryID == date ? Color.coolgray50 : Color.clear)
                }
            }
            .padding(.horizontal, 8)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offsetX = value.translation.width
                    let velocityX = value.velocity.width
                    if abs(velocityX) > 100 {
                        if offsetX < -50 { // 오른쪽으로 스와이프
                            viewModel.goToNextMonth()
                        } else if offsetX > 50 { // 왼쪽으로 스와이프
                            viewModel.goToPreviousMonth()
                        }
                    }
                }
        )
        .frame(alignment: .top)
        .onChange(of: viewModel.currentMonth) {
            NotificationCenter.default.post(name: .calendarHeightChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let calendarHeightChanged = Notification.Name("calendarHeightChanged")
}

class CustomCalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var tappedDate: Date = Date()
    @Published var tappedDiaryID: Int = 0
    @Published var diaryData = DiaryData.sData
    
    var cancellables = Set<AnyCancellable>()
    
    // Korean Calendar Setup
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
    
    static let shortWeekly: [String] = {
        return koreaCalendar.shortWeekdaySymbols
    }()
    
    func formattedDate() -> String {
        return Self.calendarHeaderDateFormatter.string(from: tappedDate)
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
    
    // Navigation Methods
    func goToPreviousMonth() {
        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    func goToNextMonth() {
        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
    
    func goToToday() {
        currentMonth = Date()
        tappedDiaryID = 0
    }
}

// MARK: - 예제 데이터
struct DiaryData {
    let id: Int
    let primaryEmotion: String
    let createdAt: String
    
    var createdday: Int {
        let temp = String(createdAt.prefix(10))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: temp) {
            return Calendar.current.component(.day, from: date)
        }
        
        return 0
    }
    
    var createdDate: Date? {
        let temp = String(createdAt.prefix(10))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: temp) {
            return date
        }
        
        return nil
    }
    
    static let sData: [DiaryData] = [
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-01T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-03T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-04T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-15T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-12T14:19:01.273Z"),
    ]
}
