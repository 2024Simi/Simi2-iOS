//
//  CalenderView.swift
//  App
//
//  Created by 박서연 on 2024/12/16.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI


enum CalendarViewType {
    case monthly
    case weekly
}

struct CalenderView: View {
    let monthly = CustomCalendarView(viewModel: CustomCalendarViewModel())
    let weekly = WeeklyCalendarView(viewModel: CustomCalendarViewModel())
    @State private var dragOffset: CGFloat = 0
    @State private var currentView: CalendarViewType = .monthly
    
    var body: some View {
        VStack {
            switch currentView {
            case .monthly:
                VStack {
                    monthly
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(.gray.opacity(0.4))
                            .frame(width: 46, height: 4)
                        Spacer()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.dragOffset = value.translation.height // 드래그 위치 업데이트
                            }
                            .onEnded { value in
                                if abs(self.dragOffset) > 100 {
                                    withAnimation {
                                        self.currentView = .weekly
                                    }
                                }
                            }
                    )
                }
                
            case .weekly:
                VStack {
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(.gray.opacity(0.4))
                            .frame(width: 46, height: 4)
                        Spacer()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.dragOffset = value.translation.height // 드래그 위치 업데이트
                            }
                            .onEnded { value in
                                if abs(self.dragOffset) > 100 {
                                    withAnimation {
                                        self.currentView = .monthly
                                    }
                                }
                            }
                    )
                    weekly
                }
            }
            
            
        }
    }
}
struct WeeklyCalendarView: View {
    let viewModel: CustomCalendarViewModel
    var body: some View {
        VStack {
            Rectangle()
                .fill(.pink)
                .frame(height: 200)
            Text("주간 캘린더")
        }
    }
}


#Preview {
    CalenderView()
}
