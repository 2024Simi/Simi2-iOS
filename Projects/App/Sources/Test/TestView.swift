//
//  TestView.swift
//  App
//
//  Created by 박서연 on 2024/12/06.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI
import DesignSystem

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
    ]
}

class CustomCalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var tappedDate: Date = Date()
    let thisMonth: Date = Date()
}

struct CustomCalendarView: View {
    @StateObject var viewModel = CustomCalendarViewModel()
    
    @State var currentMonth = Date()
    @State var tappedDate: Date = Date()
    static let thisMonth = Date()
    let diaryData = DiaryData.sData
    
    var preMonth: Date {
        return CustomCalendarView.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth)!
    }
    
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
        return Self.calendarHeaderDateFormatter.string(from: currentMonth)
    }
    
    func firstDayOfMonth(_ date: Date) -> Int {
        let startOfMonth = CustomCalendarView.koreaCalendar.date(from: CustomCalendarView.koreaCalendar.dateComponents([.year, .month], from: currentMonth))!
        let weekday = CustomCalendarView.koreaCalendar.component(.weekday, from: startOfMonth)
        return weekday - 1 // 일요일 -> 1부터 시작
    }
    
    private func currentYear(_ date: Date) -> Int {
        return CustomCalendarView.koreaCalendar.component(.year, from: currentMonth)
    }
    
    private func returnCurrentMonth(_ date: Date) -> Int {
        return CustomCalendarView.koreaCalendar.component(.month, from: currentMonth)
    }
        
    private func dateCount(_ month: Date) -> Int {
        return CustomCalendarView.koreaCalendar.range(of: .day, in: .month, for: month)?.count ?? 0
    }
    
    private func returnOpacity() -> Bool {
        let calendar = Calendar.current
        let currentMonthStart = calendar.startOfDay(for: currentMonth)
        let thisMonthStart = calendar.startOfDay(for: CustomCalendarView.thisMonth)
        
        return currentMonthStart == thisMonthStart
    }
    
    var body: some View {
        VStack {
            let circleWidth = ((UIScreen.main.bounds.width - 52) / 7) - 8
            HStack(spacing: 8) {
                SText(formattedDate(), fontType: .bold(.title3), color: .gray900)
                Image.icChevronLeft
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                        }
                    }
                
                Image.icChevronRight
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.leading, -8)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                        }
                    }
                
                Spacer()
                
                SText("오늘", fontType: .semibold(.footnote), color: .white)
                    .padding(.init(top: 4,leading: 8,bottom: 4,trailing: 8))
                    .background(Color.gray800)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .onTapGesture {
                        withAnimation(.smooth) {
                            currentMonth = Date()
                        }
                    }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
                ForEach(CustomCalendarView.shortWeekly, id: \.self) { data in
                    Text(data)
                        .frame(width: circleWidth)
                        .foregroundStyle(data == "일" ? Color.red : Color.black)
                }
                
                let lastDateOfCalendar = numberOfWeeks(in: currentMonth) - firstDayOfMonth(currentMonth)
                
                ForEach((-firstDayOfMonth(currentMonth)+1) ... lastDateOfCalendar, id: \.self) { date in
                    let column = (date + firstDayOfMonth(currentMonth) - 1) % 7 == 0
                    let dateComponent = DateComponents(year: currentYear(currentMonth), month: returnCurrentMonth(currentMonth), day: date)
                    let calculatedDateComponent = Calendar.current.date(from: dateComponent) ?? Date()
                    let isToday = Calendar.current.isDateInToday(calculatedDateComponent)
                    let isPastDate = calculatedDateComponent < Calendar.current.startOfDay(for: Date())
                    let isMatched = diaryData.contains { $0.createdDate == calculatedDateComponent }
                    
                    VStack(spacing: 0){
                        Circle()
                            .frame(width: 4, height: 4)
                            .opacity(isMatched ? 1.0 : 0.0)
                        
                        if date <= 0 {
                            let preDate = dateCount(preMonth) + date
                            Text("\(preDate)")
                                .foregroundStyle(date+firstDayOfMonth(preMonth) == 1 ? .red : .black)
                                .opacity(isPastDate ? 0.5 : 1.0)
                            
                        } else if date > 0 && date <= dateCount(currentMonth) {
                            if isToday {
                                Circle()
                                    .frame(width: circleWidth, height: circleWidth)
                                    .overlay {
                                        Text("\(date)")
                                            .foregroundStyle(Color.white)
                                    }
                            } else {
                                VStack(spacing: 0) {
                                    Text("\(date)")
                                        .foregroundStyle(column ? Color.red : Color.black)
                                        .frame(width: circleWidth, height: circleWidth)
                                        .opacity(isPastDate ? 0.5 : 1.0)
                                }
                            }
                        } else {
                            let nextMonthDay = date - dateCount(currentMonth)
                            Text("\(nextMonthDay)")
                                .foregroundStyle(Color.black)
                                .frame(width: circleWidth, height: circleWidth)
                                .opacity(isPastDate ? 0.5 : 1.0)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offsetX = value.translation.width
                    
                    withAnimation(.smooth) { // 애니메이션.. 확인 필요...
                        if offsetX < -50 { // 오른쪽으로 스와이프
                            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                        } else if offsetX > 50 { // 왼쪽으로 스와이프
                            currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                        }
                    }
                }
        )
    }
    
    func numberOfWeeks(in month: Date) -> Int {
        let calendar = CustomCalendarView.koreaCalendar
        
        guard let firstDayMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)),
              let range = calendar.range(of: .day, in: .month, for: month) else {
            return 0
        }
        
        let lastDayOfMonth = calendar.date(byAdding: .day, value: range.count - 1, to: firstDayMonth)!
        let firstWeek = calendar.component(.weekOfMonth, from: firstDayMonth)
        let lastWeek = calendar.component(.weekOfMonth, from: lastDayOfMonth)
        
        // 주의 개수 = 마지막 주 - 첫 번째 주 + 1
        // 전체 cell의 개수 = 7 * 주의 개수 - 첫째주의 일자수
        return (lastWeek - firstWeek + 1) * 7
    }
}


#Preview {
    CustomCalendarView()
}

