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
import Models
import Services

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
                SText(viewModel.dateTitle, fontType: .bold(.title3), color: .gray900)
                Image.icChevronLeft
                    .resizable()
                    .frame(width: 32, height: 32)
                    .onTapGesture {
                        viewModel.goToPreviousMonth()
                        viewModel.send(.formattedDate)
                        viewModel.send(.getDairyData)
                    }
                
                Image.icChevronRight
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.leading, -8)
                    .onTapGesture {
                        viewModel.goToNextMonth()
                        viewModel.send(.formattedDate)
                    }
                
                Spacer()
                
                SText("오늘", fontType: .semibold(.footnote), color: .white)
                    .padding(.init(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .background(Color.gray800)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .onTapGesture {
                        viewModel.goToToday()
                        viewModel.send(.formattedDate)
                        viewModel.isToday = true
                        viewModel.isPaste = false
                        viewModel.send(.calculatedUnderTitle(Date()))
                        viewModel.send(.calculatedTappedDiaryId(Date()))
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
                    let isFuture = calculatedDateComponent > Calendar.current.startOfDay(for: Date())
                    
                    VStack(spacing: 0) {
                        Circle()
                            .fill(viewModel.calculatePrimaryEmotionColor(calculatedDateComponent))
                            .frame(width: 4, height: 4)
                            .opacity(isMatched ? 1.0 : 0.0)
                        
                        if date <= 0 {
                            let preDate = viewModel.dateCount(preMonth) + date
                            SText("\(preDate)", fontType: viewModel.tappedDiaryID == date ? .bold(.body) : .semibold(.body), color: date+viewModel.firstDayOfMonth(preMonth) == 1 ? .red : .black)
                                .opacity(viewModel.tappedDateString == date ? 1.0 : (isPastDate ? 0.5 : 1.0))
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
                                    .opacity(viewModel.tappedDateString == date ? 1.0 : (isPastDate ? 0.5 : 1.0))
                            }
                        } else {
                            let nextMonthDay = date - viewModel.dateCount(viewModel.currentMonth)
                            SText("\(nextMonthDay)", fontType: viewModel.tappedDateString == date ? .bold(.body) : .semibold(.body), color: column ? Color.red : Color.black)
                                .frame(width: circleWidth, height: 40)
                                .opacity(isPastDate ? 0.5 : 1.0)
                        }
                    }
                    .frame(height: 44)
                    .onTapGesture {
                        viewModel.isToday = isToday
                        if isToday {
                            viewModel.isPaste = false
                        } else {
                            (isPastDate && !isMatched) ? (viewModel.isPaste = true) : (viewModel.isPaste = false)
                        }

                        viewModel.tappedDiaryID = date
                        viewModel.tappedDateString = date
                        viewModel.tappedDate = calculatedDateComponent
                        viewModel.send(.calculatedUnderTitle(calculatedDateComponent))
                        viewModel.send(.calculatedTappedDiaryId(calculatedDateComponent))
                        viewModel.send(.calculatedIsDiary(calculatedDateComponent))
                    }
                    .background((viewModel.tappedDateString == date && !isToday) ? Color.coolgray50 : Color.clear)
                    .disabled(isFuture)
                }
            }
            .padding(.horizontal, 8)
        }
        .onAppear {
            viewModel.send(.formattedDate)
            viewModel.send(.getDairyData)
            viewModel.send(.calculatedUnderTitle(viewModel.tappedDate))
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    let offsetX = value.translation.width
                    let velocityX = value.velocity.width
                    if abs(velocityX) > 100 {
                        if offsetX < -50 { // 오른쪽으로 스와이프
                            viewModel.goToNextMonth()
                            viewModel.send(.formattedDate)
                        } else if offsetX > 50 { // 왼쪽으로 스와이프
                            viewModel.goToPreviousMonth()
                            viewModel.send(.formattedDate)
                            viewModel.send(.getDairyData)
                        }
                    }
                }
        )
        .onChange(of: viewModel.currentMonth) {
            NotificationCenter.default.post(name: .calendarHeightChanged, object: nil)
        }
        .onChange(of: viewModel.underDateTitle) {
            NotificationCenter.default.post(name: .calenderUnderTitleChanged, object: nil)
        }
        .onChange(of: viewModel.isPaste) {
            NotificationCenter.default.post(name: .calendarIspateChanged, object: nil)
        }
        .onChange(of: viewModel.isToday) {
            NotificationCenter.default.post(name: .calendarIspateChanged, object: nil)
        }
    }
}

extension Notification.Name {
    static let calendarHeightChanged = Notification.Name("calendarHeightChanged")
    static let calenderUnderTitleChanged = Notification.Name("calenderUnderTitleChanged")
    static let calendarIspateChanged = Notification.Name("calendarIspateChanged")
}
