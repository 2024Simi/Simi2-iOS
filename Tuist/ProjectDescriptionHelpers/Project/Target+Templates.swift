//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 박서연 on 2024/09/22.
//

import ProjectDescription

public extension Target {
    private static let environmentSettings = EnvironmentSettings.default
    private static let organizationName = environmentSettings.organizationName
    private static let destinations = environmentSettings.destinations
    private static let deploymentTargets = environmentSettings.deploymentTargets
    private static let defaultSettings = DefaultSettings.recommended(excluding: [
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
    ])
    
    static func moduleTarget(
        name: String,
        product: Product = .staticLibrary,
        resources: Bool = false,
        dependencies: [Module] = [],
        infoPlist: Bool = false,
        setting: Bool = false
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "com.\(organizationName).\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist
            ? .file(path: "Support/Info.plist") : nil,
            sources: ["Sources/**"],
            resources: resources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: setting
            ? Configuration.getSetting(name: name)
            : Configuration.noneSettings
        )
    }
    
    static func multiTarget(
        name: String,
        product: Product = .staticLibrary,
        resources: Bool = false,
        dependencies: [Module] = [],
        infoPlist: Bool = false,
        setting: Bool = false
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: "com.\(organizationName).\(name)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist
            ? .file(path: "Support/Info.plist") : nil,
            sources: ["\(name)/Sources/**"],
            resources: resources ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: setting
            ? Configuration.getSetting(name: name)
            : Configuration.noneSettings
        )
    }
    
    static func appTarget(
        name: String,
        dependencies: [Module] = [],
        infoPlist: Bool = false
    ) -> Target {
        let dependencies = dependencies.map { $0.setDependency() }
        
        return Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.\(name).\(organizationName)",
            deploymentTargets: deploymentTargets,
            infoPlist: infoPlist
            ? .file(path: "Support/Info.plist") : .default,
            sources: ["Sources/**"],
            resources: nil,
            //            entitlements: "\(name).entitlements", // 추가 후 주석 해제
            dependencies: dependencies,
            settings: Configuration.defaultSettings
        )
    }
}
