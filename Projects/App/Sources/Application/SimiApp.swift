//
//  SimiApp.swift
//  App
//
//  Created by 박서연 on 2024/12/06.
//  Copyright © 2024 inner-dev. All rights reserved.
//

import SwiftUI

@main
struct SimiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CustomCalendarView()
        }
    }
}
