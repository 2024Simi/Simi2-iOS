//
//  WeeklyCalendarView.swift
//  Home
//
//  Created by cha_nyeong on 2025/03/04.
//  Copyright © 2025 inner-dev. All rights reserved.
//

import SwiftUI
import DesignSystem
import Combine
import Models
import Services

struct WeeklyCalendarView: View {
    @ObservedObject var viewModel: WeeklyCalendarViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            let circleWidth = ((UIScreen.main.bounds.width - 52) / 7) - 8
            
            HStack(spacing: 8) {
                SText(viewModel.formattedDate(), fontType: .bold(.title3), color: .gray900)
                Image.icChevronLeft
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        viewModel.goToPreviousWeek()
                    }
                
                Image.icChevronRight
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.leading, -8)
                    .onTapGesture {
                        viewModel.goToNextWeek()
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
            
            // Weekly calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 12) {
                // Weekday headers
                ForEach(WeeklyCalendarViewModel.shortWeekly, id: \.self) { data in
                    SText(data, fontType: .semibold(.caption1))
                        .frame(width: circleWidth, height: 22)
                        .foregroundStyle(data == "일" ? Color.red : Color.black)
                }
                .padding(.vertical, 12)
                
                // Week days
                ForEach(viewModel.currentWeekDates, id: \.self) { date in
                    let calendar = Calendar.current
                    let dayOfWeek = calendar.component(.weekday, from: date)
                    let dayNumber = calendar.component(.day, from: date)
                    let isToday = calendar.isDateInToday(date)
                    let isPastDate = date < calendar.startOfDay(for: Date())
                    let isMatched = viewModel.diaryData.contains { $0.createdDate == date }
                    let isSelected = viewModel.tappedDate == date
                    
                    VStack(spacing: 0) {
                        Circle()
                            .fill(Color.happy)
                            .frame(width: 4, height: 4)
                            .opacity(isMatched ? 1.0 : 0.0)
                        
                        if isToday {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: circleWidth, height: 40)
                                .overlay {
                                    Circle()
                                        .frame(width: circleWidth-8, height: 32)
                                        .overlay {
                                            SText("\(dayNumber)", fontType: .semibold(.body), color: .white)
                                        }
                                }
                        } else {
                            SText("\(dayNumber)", fontType: isSelected ? .bold(.body) : .semibold(.body), color: dayOfWeek == 1 ? Color.red : Color.black)
                                .frame(width: circleWidth, height: 40)
                                .opacity(isSelected ? 1.0 : (isPastDate ? 0.5 : 1.0))
                        }
                    }
                    .frame(height: 44)
                    .onTapGesture {
                        if isPastDate {
                            viewModel.tappedDate = date
                        }
                    }
                    .background(isSelected ? Color.coolgray50 : Color.clear)
                }
            }
            .padding(.horizontal, 8)
        }
        .onAppear {
            viewModel.getDiaryData()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offsetX = value.translation.width
                    let velocityX = value.velocity.width
                    if abs(velocityX) > 100 {
                        if offsetX < -50 { // 오른쪽으로 스와이프
                            viewModel.goToNextWeek()
                        } else if offsetX > 50 { // 왼쪽으로 스와이프
                            viewModel.goToPreviousWeek()
                        }
                    }
                }
        )
        .frame(alignment: .top)
        .onChange(of: viewModel.currentWeekStart) {
            NotificationCenter.default.post(name: .calendarWeekChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let calendarWeekChanged = Notification.Name("calendarWeekChanged")
}

class WeeklyCalendarViewModel: ObservableObject {
    @Published var currentWeekStart: Date
    @Published var tappedDate: Date
    @Published var currentWeekDates: [Date] = []
    @Published var diaryData: [DiaryEntity] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let diaryService = DiaryService(apiService: ApiService())
    
    init() {
        let calendar = Self.koreaCalendar
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysToSubtract = weekday - 1 // to get to Sunday (1)
        if let sunday = calendar.date(byAdding: .day, value: -daysToSubtract, to: today) {
            self.currentWeekStart = sunday
            self.tappedDate = today
        } else {
            self.currentWeekStart = today
            self.tappedDate = today
        }
        
        updateWeekDates()
    }
    
    func updateWeekDates() {
        currentWeekDates = (0..<7).compactMap { day in
            Self.koreaCalendar.date(byAdding: .day, value: day, to: currentWeekStart)
        }
    }
    
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
    
    // Navigation Methods
    func goToPreviousWeek() {
        if let newDate = Self.koreaCalendar.date(byAdding: .day, value: -7, to: currentWeekStart) {
            currentWeekStart = newDate
            updateWeekDates()
        }
    }
    
    func goToNextWeek() {
        if let newDate = Self.koreaCalendar.date(byAdding: .day, value: 7, to: currentWeekStart) {
            currentWeekStart = newDate
            updateWeekDates()
        }
    }
    
    func goToToday() {
        let calendar = Self.koreaCalendar
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysToSubtract = weekday - 1 // to get to Sunday (1)
        if let sunday = calendar.date(byAdding: .day, value: -daysToSubtract, to: today) {
            currentWeekStart = sunday
            tappedDate = today
            updateWeekDates()
        }
    }
    
    func getDiaryData() {
        diaryService.getDiary(startDate: "2024-10-01", endDate: "2024-10-10")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("🔵 Diary Success!")
                case .failure(let error):
                    print("🔴 Diary Failure! \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] diary in
                self?.diaryData = diary
            }
            .store(in: &cancellables)
    }
}