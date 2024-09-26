//
//  SceneDelegate.swift
//  App
//
//  Created by 박서연 on 2024/09/25.
//  Copyright © 2024 simi2-2024. All rights reserved.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = FontTestViewController()  // Root View Controller 설정
        window?.makeKeyAndVisible()  // Window를 키 및 보이게 설정
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 사용자가 앱을 종료할 때 실행되는 코드
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 앱이 활성화되어 사용 가능한 상태가 되었을 때 실행되는 코드
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 앱이 비활성화되어 일시 중지된 상태가 될 때 실행되는 코드
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 앱이 백그라운드에서 포그라운드로 전환되기 직전에 실행되는 코드
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 앱이 백그라운드로 들어갔을 때 실행되는 코드
    }
}

