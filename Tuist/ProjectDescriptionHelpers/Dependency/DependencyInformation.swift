//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/24.
//

import Foundation
import ProjectDescription

public enum Module {
    case core(Core)
    case coordinator(Coordinator)
    case scene(Scene)
    case designSystem
    case spm(SPM)
}

public enum Core: String {
    case common = "Common"
    case model = "Models"
    case service = "Services"
}

public enum Coordinator: String {
    case homeCoordinator = "homeCoordinator"
    case app = "AppCoordinator"
}

public enum Scene: String {
    case home = "Home"
}

public enum SPM: String {
    case lottie = "Lottie"
    case kakaoIosSdk = "KakaoSDK"
    case swiftyJSON = "swiftyJSON"
    case firebase = "firebase"
}

extension Module {
    public func setDependency() -> TargetDependency {
        switch self {
        case .core(let core):
            return .project(target: core.rawValue, path: .relativeToRoot("Projects/Core"))
            
        case .designSystem:
            return .project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem"))
            
        case .coordinator(let coordinator):
            return .project(target: coordinator.rawValue, path: .relativeToRoot("Projects/Feature/Coordinator"))
            
        case .scene(let scene):
            return .project(target: scene.rawValue, path: .relativeToRoot("Projects/Feature/Scene"))
            
        case .spm(let spm):
            return .external(name: spm.rawValue)
        }
    }
}
