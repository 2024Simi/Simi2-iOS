//
//  AppDelegate.swift
//  App
//
//  Created by 박서연 on 2024/09/25.
//  Copyright © 2024 simi2-2024. All rights reserved.
//

import UIKit
import UserNotifications

import Common
import DesignSystem
import Firebase
import FirebaseMessaging

//@main
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
        
        /// 알림 권한 요청
        NotificationManager.shared.checkNotificationPermission()
        
        /// APNs 등록 요청
        UIApplication.shared.registerForRemoteNotifications()

        return true
    }
    
    // MARK: - APNs 등록 성공
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        KeyChain.create(key: "apns", token: tokenString)
        print("✅ APNs Device Token: \(tokenString)")
        Messaging.messaging().apnsToken = deviceToken
    }

    // MARK: - APNs 등록 실패
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ APNs 등록 실패: \(error.localizedDescription)")
    }
}

// MARK: - MessagingDelegate (FCM 토큰 가져오기)
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else {
            print("❌ FCM 토큰을 가져오지 못했습니다.")
            return
        }

        KeyChain.create(key: "fcm", token: fcmToken)
        print("✅ FCM 등록 토큰: \(fcmToken)")
    }
}
