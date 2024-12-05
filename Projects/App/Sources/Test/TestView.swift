//
//  TestView.swift
//  App
//
//  Created by 박서연 on 2024/12/06.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI

struct DiaryData {
    let id: Int
    let primaryEmotion: String
    let createdAt: String
    
    var createdday: Int {
        let temp = ISO8601DateFormatter().date(from: createdAt)!
        let calendar = Calendar.current
        
        return calendar.component(.day, from: temp)
    }
    
    static let sData: [DiaryData] = [
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-01T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-02T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-03T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-04T14:19:01.273Z"),
        .init(id: 0, primaryEmotion: "HAPPY", createdAt: "2024-12-05T14:19:01.273Z")
    ]
}

class CustomCalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var tappedDate: Date = Date()
    let thisMonth: Date = Date()
}

struct CustomCalendarView: View {
    @StateObject var viewModel = CustomCalendarViewModel()
    
    @State var currentMonth = Date() //CustomCalendarView.koreaCalendar.date(byAdding: .month, value: 3, to: Date())!//
    @State var tappedDate: Date = Date()
    static let thisMonth = Date()
    
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
            Text(currentMonth, formatter: Self.calendarHeaderDateFormatter)
                .padding(10)
                .background(.gray)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
                ForEach(CustomCalendarView.shortWeekly, id: \.self) { data in
                    Text(data)
                        .frame(width: circleWidth)
                        .foregroundStyle(data == "일" ? Color.red : Color.black)
                }
                
                let lastDateOfCalendar = numberOfWeeks(in: currentMonth) - firstDayOfMonth(currentMonth)
                
                ForEach((-firstDayOfMonth(currentMonth)+1) ... lastDateOfCalendar, id: \.self) { date in
                    let column = (date + firstDayOfMonth(currentMonth) - 1) % 7 == 0
                    
                    let temp = DateComponents(year: currentYear(currentMonth), month: returnCurrentMonth(currentMonth), day: date)
                    let calculatedDateComponent = Calendar.current.date(from: temp) ?? Date()
                    let isToday = Calendar.current.isDateInToday(calculatedDateComponent)
                    let isPastDate = calculatedDateComponent < Calendar.current.startOfDay(for: Date())
                    
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
                            Text("\(date)")
                                .foregroundStyle(column ? Color.red : Color.black)
                                .frame(width: circleWidth, height: circleWidth)
                                .opacity(isPastDate ? 0.5 : 1.0)
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
            .padding(.horizontal, 8)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offsetX = value.translation.width
                    
                    if offsetX < -50 { // 오른쪽으로 스와이프
                        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                    } else if offsetX > 50 { // 왼쪽으로 스와이프
                        currentMonth = Self.koreaCalendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
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

