//
//  AppDelegate.swift
//  App
//
//  Created by 박서연 on 2024/09/25.
//  Copyright © 2024 simi2-2024. All rights reserved.
//

import Foundation
import UIKit
import DesignSystem

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DesignSystemFontFamily.registerAllCustomFonts()
        
//        for family in UIFont.familyNames {
//            let sName: String = family as String
//            print("Font family: \(sName)")
//            
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("Font name: \(name as String)")
//            }
//        }
        
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}
}

