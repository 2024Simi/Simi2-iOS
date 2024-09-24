//
//  TargetDependency.swift
//  Config
//
//  Created by cha_nyeong on 9/5/24.
//

import Foundation
import ProjectDescription

public enum Module {
    case core(Core)
    case coordinator(Coordinator)
    case designSystem
    case scene(Scene)
    case spm(SPM)
}

public enum Core: String {
    case common = "Common"
    case model = "Models"
    case service = "Services"
}

public enum Coordinator: String {
    case home = "HomeCoordinator"
    case app = "AppCoordinator"
}

public enum Scene: String {
    case home = "Home"
}

public enum SPM: String {
    case lottie = "Lottie"
    case kakaoIosSdk = "Kakao-ios-SDK"
    case swiftyJSON = "swiftyJSON"
}

extension Module {
    public func asTargetDependency() -> TargetDependency {
        switch self {
        case .core(let core):
            return .project(target: core.rawValue, path: .relativeToRoot("Projects/Core"))
            
        case .coordinator(let coordinator):
            return .project(target: coordinator.rawValue, path: .relativeToRoot("Projects/Features/Coordinator"))
            
        case .designSystem:
            return .project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
            
        case .scene(let scene):
            return .project(target: scene.rawValue, path: .relativeToRoot("Projects/Features/Scene"))
            
        case .spm(let spm):
            return .external(name: spm.rawValue)
        }
    }
}
